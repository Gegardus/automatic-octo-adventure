# frozen_string_literal: true

module ControllerTestHelper
  def assert_text(text)
    assert_select '*', text: /#{text}/
  end

  def assert_success_alert(text)
    assert_alert(type: :success, text: text)
  end

  def assert_danger_alert(text)
    assert_alert(type: :danger, text: text)
  end

  def assert_page_header(text)
    assert_select 'h1', text: /#{text}/
  end

  def assert_form(url:)
    assert_select "form[action='#{url}']"
  end

  private

  def assert_alert(type:, text:)
    follow_redirect! if response.redirect?

    assert_select ".Alert--#{type}", text: text
  end
end
