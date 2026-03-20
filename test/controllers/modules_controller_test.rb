# frozen_string_literal: true

require 'test_helper'

class ModulesControllerTest < ActionDispatch::IntegrationTest
  test 'shows modules' do
    given_signed_in_as :ben

    get modules_path

    assert_page_header 'Modules'
  end

  test '#index' do
    given_signed_in_as :bob

    inquiry = inquiries(:fitpal)

    inquiry.update!(status: :submitted,
                    submission_confirmed: true,
                    submission_date: Time.zone.today,
                    submission_full_name: 'Bob')

    get modules_path

    assert_response :success

    assert_text 'Awaiting approval'
  end
end
