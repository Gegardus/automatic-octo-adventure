# frozen_string_literal: true

require 'application_system_test_case'

class RefiningYourIdeaApplicationModuleTest < ApplicationSystemTestCase
  test 'refining your idea module' do
    ApplicationModules.stub_any_instance :module_active?, ->(_step) { true } do
      # Given I am an applicant
      given_signed_in_as :jim
      visit root_path

      click_link 'Modules'

      # When I fill in the module's questions and sections with details
      click_button 'Module 2: Refine Your Idea'

      # And i can see it completed
      complete_refining_your_idea_module

      # Then the refining your idea is submitted
      assert_refining_your_idea_submitted
    end
  end
end
