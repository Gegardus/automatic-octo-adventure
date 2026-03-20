# frozen_string_literal: true

require 'test_helper'

class ApplicantHelpRequestsControllerTest < ActionDispatch::IntegrationTest
  test 'index' do
    help_request = help_requests(:consult_request)

    given_signed_in_as :bob

    get applicant_help_requests_path

    assert_text help_request.details
  end

  test '#new' do
    given_signed_in_as :bob

    get new_applicant_help_request_path

    assert_page_header 'New help request'

    assert_form url: applicant_help_requests_path
  end

  test '#create' do
    given_signed_in_as :bob

    admins_count = User.admin.count

    assert_emails admins_count do
      post applicant_help_requests_path, params: {
        help_request: valid_help_request_attributes
      }
    end

    assert_response :redirect

    assert_success_alert 'Help request was successfully created.'
  end

  test '#create fails' do
    given_signed_in_as :bob

    post applicant_help_requests_path, params: {
      help_request: valid_help_request_attributes.merge({ details: '' })
    }

    assert_danger_alert "Details can't be blank"
  end

  test '#show' do
    help_request = help_requests(:consult_request)
    given_signed_in_as :bob

    get applicant_help_request_path(help_request)

    assert_response :success

    assert_text help_request.details
  end

  private

  def valid_help_request_attributes
    {
      details: 'I dont know what to do',
      module_name: :pre_incubation,
      module_section: :confirmation
    }
  end
end
