# frozen_string_literal: true

require 'test_helper'

class HelpRequestsControllerTest < ActionDispatch::IntegrationTest
  test 'index' do
    help_request = help_requests(:consult_request)

    given_signed_in_as :dom

    get help_requests_path

    assert_text help_request.details
  end

  test 'show' do
    help_request = help_requests(:consult_request)

    given_signed_in_as :dom

    get help_request_path(help_request)

    assert_text 'Suggestions on tax policy'
  end

  test 'edit' do
    help_request = help_requests(:consult_request)

    given_signed_in_as :dom

    get edit_help_request_path(help_request)

    assert_text 'Dom Smith'
  end

  test 'update' do
    lily = users(:lily)
    help_request = help_requests(:consult_request)

    given_signed_in_as :dom

    put help_request_path(help_request), params: {
      help_request: {
        admin_id: lily.id
      }
    }

    assert_redirected_to help_request

    assert_equal lily, help_request.reload.admin
  end
end
