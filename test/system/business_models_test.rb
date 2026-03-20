# frozen_string_literal: true

require 'application_system_test_case'

class BusinessModelsTest < ApplicationSystemTestCase
  test 'business model module' do
    ApplicationModules.stub_any_instance :module_active?, ->(_step) { true } do
      # Given I am an applicant
      given_signed_in_as :jim

      # When I go through the modules pages and fill in the questions with my business plan
      visit business_models_path(section: :getting_started_with_business_plan)

      # And I complete business model module
      complete_business_model_module

      # Then the business model is submitted
      assert_business_model_submitted
    end
  end
end
