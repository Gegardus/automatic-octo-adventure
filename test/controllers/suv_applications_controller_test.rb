# frozen_string_literal: true

require 'test_helper'

class SuvApplicationsControllerTest < ActionDispatch::IntegrationTest
  test '#index' do
    suv_application = suv_applications(:fitpal_application)

    given_signed_in_as :dom

    get suv_applications_path

    assert_response :success

    assert_page_header 'Teams'

    assert_text suv_application.team_name
  end

  test '#show' do
    suv_application = suv_applications(:medical_diagnostic_clinic_application)

    given_signed_in_as :dom

    get suv_application_path(suv_application)

    assert_response :success
  end
end
