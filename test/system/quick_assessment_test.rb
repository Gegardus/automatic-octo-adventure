# frozen_string_literal: true

require 'application_system_test_case'

class QuickAssessmentsTest < ApplicationSystemTestCase
  test 'updating quick assessment' do
    # Given i am an applicant
    given_signed_in_as :jim
    visit root_path

    # When i fill in questionnaire of the quick assessment
    complete_quick_assessment_module

    # Then the quick assessment is submitted
    assert_quick_assessment_submitted
  end
end
