# frozen_string_literal: true

require 'test_helper'

class ResponsivenessAssessmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @responsiveness_assessment = responsiveness_assessments(:bobs_sensitivity)
  end

  test '#edit' do
    given_signed_in_as :bob

    get edit_responsiveness_assessments_path(@responsiveness_assessment)

    assert_response :success

    assert_page_header 'Responsiveness assessment'

    assert_form url: responsiveness_assessments_path
  end

  test '#update' do
    given_signed_in_as :bob

    put responsiveness_assessments_path, params: {
      responsiveness_assessment: { 'is_animated' => '@responsiveness_assessment.is_animated',
                                   'is_approachable' => '@responsiveness_assessment.is_approachable',
                                   'is_casual' => '@responsiveness_assessment.is_casual',
                                   'is_informal' => '@responsiveness_assessment.is_informal',
                                   'is_intuitive' => '@responsiveness_assessment.is_intuitive',
                                   'is_open' => '@responsiveness_assessment.is_open',
                                   'is_outgoing' => '@responsiveness_assessment.is_outgoing',
                                   'is_random' => '@responsiveness_assessment.is_random',
                                   'is_unstructured' => '@responsiveness_assessment.is_unstructured',
                                   'is_warm' => '@responsiveness_assessment.is_warm' }
    }

    assert_response :redirect

    assert_success_alert 'Responsiveness assessment was successfully updated.'
  end
end
