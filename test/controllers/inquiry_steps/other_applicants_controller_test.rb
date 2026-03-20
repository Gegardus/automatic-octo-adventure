# frozen_string_literal: true

require 'test_helper'

module InquirySteps
  class OtherApplicantsControllerTest < ActionDispatch::IntegrationTest
    test '#new' do
      bob = given_signed_in_as :bob

      get new_inquiry_steps_other_applicant_path(bob.inquiry)

      assert_page_header 'Another applicant'

      assert_form url: inquiry_steps_other_applicants_path
    end

    test '#create' do
      bob = given_signed_in_as :bob
      suv_application = bob.suv_application

      assert_emails 1 do
        assert_difference 'suv_application.applicants.count' do
          post inquiry_steps_other_applicants_path, params: {
            user: {
              email: 'jole@test.com',
              first_name: 'Jole',
              last_name: 'Spencer',
              suv_application_id: suv_application.id
            }
          }
        end
        assert_redirected_to inquiry_steps_applicant_detail_path
      end
    end
  end
end
