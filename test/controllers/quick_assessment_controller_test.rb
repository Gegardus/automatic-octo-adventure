# frozen_string_literal: true

require 'test_helper'

class QuickAssessmentControllerTest < ActionDispatch::IntegrationTest
  test '#new' do
    given_signed_in_as(:bob)

    get new_quick_assessment_path

    assert_response :success
  end

  test '#show' do
    given_signed_in_as(:bob)

    bob = users(:bob)

    get quick_assessment_path(bob)

    assert_response :success
  end

  test '#show redirects to modules when next step is nil and all steps are skipped or completed' do
    given_signed_in_as :jim

    jim = users(:jim)
    SkippedStep.create!(
      suv_application: jim.suv_application,
      step_name: :results,
      module_name: 'quick_assessment'
    )

    get quick_assessment_path(jim)

    assert_redirected_to modules_path
  end
end
