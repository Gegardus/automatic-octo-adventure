# frozen_string_literal: true

require 'test_helper'

class AdditionalInformationsControllerTest < ActionDispatch::IntegrationTest
  test '#show' do
    fitpal = inquiries(:fitpal)
    given_signed_in_as :bob

    get inquiry_steps_additional_informations_path

    assert_text fitpal.reason_for_interest
  end

  test '#edit' do
    given_signed_in_as :bob

    get edit_inquiry_steps_additional_informations_path

    assert_text 'Why are you interested in Canadian Startup Program?'

    assert_form url: inquiry_steps_additional_informations_path
  end

  test '#update' do
    fitpal = inquiries(:fitpal)
    given_signed_in_as :bob

    patch inquiry_steps_additional_informations_path, params: {
      inquiry: {
        reason_for_interest: 'i am next elon musk',
        where_did_you_hear_about_us: 'Google',
        startup_location: 'Toronto'
      }
    }

    assert_redirected_to inquiry_steps_additional_informations_path

    assert_equal 'i am next elon musk', fitpal.reload.reason_for_interest
  end
end
