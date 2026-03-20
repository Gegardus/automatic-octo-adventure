# frozen_string_literal: true

require 'test_helper'
require 'capybara-email'

require_relative 'modules_system_test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include ModulesSystemTestHelper
  include Capybara::Email::DSL

  def fill_in(field_label, with:, match: nil)
    super(field_label, with: with, match: match || :prefer_exact)
  end

  def assert_page_header(text)
    assert_selector 'h1', text: /#{text}/
  end

  def fill_in_trix_editor(label, with:)
    if js?
      assert evaluate_script('window.trixEditorLoaded')
      fill_in_rich_text_area label, with: with
    else
      find(:xpath, hidden_trix_editor_input_xpath_expression(label).to_xpath, visible: false).set(with)
    end
  end

  def js?
    Capybara.current_driver != :rack_test
  end

  def within_turbo_frame(id: nil)
    return yield if js?

    original_url = current_url

    frame = find_turbo_frame(id: id)
    frame_src_path = frame['src']

    current_uri = URI.parse(page.current_url)
    frame_src_url = "#{current_uri.scheme}://#{current_uri.host}:#{current_uri.port}#{frame_src_path}"

    visit frame_src_url

    yield

    visit original_url
  end

  def fill_in_multi_select(option_text, from:, exact: false)
    return select(option_text, from: from, exact: exact) unless js?

    select = find('label', text: from, exact_text: exact).find(:xpath, './following-sibling::div/button')

    select.click

    within(select.find(:xpath, '../div')) do
      find('span', text: option_text, exact_text: exact).click
    end

    select.click
  end

  private

  def find_turbo_frame(id: nil)
    html = Nokogiri::HTML(body)
    if id
      html.at_css("turbo-frame[id='#{id}']")
    else
      frames = html.css('turbo-frame')
      raise 'More than one turbo-frame found. Please specify an ID.' if frames.size > 1

      frames.first
    end
  end

  def trix_editor_xpath_expression(label, xpath = XPath)
    xpath.descendant(:'trix-editor')[
      XPath.attr(:id) == XPath.axis(:parent).descendant(:label)[XPath.text == label].attr(:for)
    ]
  end

  def hidden_trix_editor_input_xpath_expression(_label)
    XPath.descendant(:input)[
      XPath.attr(:id) == 'resource_content_trix_input_resource' # This is based on the provided HTML structure
    ][XPath.attr(:type) == 'hidden']
  end
end
