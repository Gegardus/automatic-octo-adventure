# frozen_string_literal: true

require 'application_system_test_case'

class ApplicantInquiryTest < ApplicationSystemTestCase
  test 'submitting an inquiry and confirmation' do
    # Given i want to inquire about start up visa program
    visit root_url

    # When i create an account
    create_account

    # And i complete the inquiry module
    complete_inquiry_module

    # Then the inquiry is submitted
    assert_inquiry_submitted
  end
end
