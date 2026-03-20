# frozen_string_literal: true

require 'application_system_test_case'

class ApplicantSuvApplicationTest < ApplicationSystemTestCase
  test 'end to end completing all modules for a new user' do
    # Given i want to inquire about start up visa program
    visit root_url

    # When i create an account
    create_account

    # And complete inquiry module
    complete_inquiry_module

    # Then the inquiry is submitted
    assert_inquiry_submitted

    # When i complete quick assessment module
    complete_quick_assessment_module

    # Then the quick assessment is submitted
    assert_quick_assessment_submitted

    # When i complete immigration module
    complete_immigration_module

    # Then the immigration is submitted
    assert_immigration_submitted

    # When i complete refining your idea module
    complete_refining_your_idea_module

    # Then the refining your idea is submitted
    assert_refining_your_idea_submitted

    # When i complete registration documents module
    complete_registration_documents_module

    # Then the registration documents is submitted
    assert_registration_documents_submitted
  end
end
