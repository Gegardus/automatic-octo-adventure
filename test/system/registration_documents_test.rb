# frozen_string_literal: true

require 'application_system_test_case'

class RegistrationDocumentsTest < ApplicationSystemTestCase
  test 'registration documents module' do
    ApplicationModules.stub_any_instance :module_active?, ->(_step) { true } do
      # Given i am an applicant
      given_signed_in_as :jim
      visit root_path

      # When i complete the registration documents module
      click_link 'Modules'

      click_button 'Module 3: Legal, Taxation & Incorporation'

      # And I get acquainted with the rules for registering a business in Canada
      complete_registration_documents_module

      # Then the registration documents is submitted
      assert_registration_documents_submitted
    end
  end
end
