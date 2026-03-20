# frozen_string_literal: true

require 'test_helper'

class AssertivenessAssessmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @assertiveness_assessment = assertiveness_assessments(:bobs_drive)
  end

  test '#edit' do
    given_signed_in_as :bob

    get edit_assertiveness_assessments_path(@assertiveness_assessment)

    assert_response :success

    assert_page_header 'Assertiveness assessment'

    assert_form url: assertiveness_assessments_path
  end

  test '#update' do
    given_signed_in_as :bob

    put assertiveness_assessments_path, params: {
      assertiveness_assessment: { 'is_bold' => '@assertiveness_assessment.is_bold',
                                  'is_challenging' => '@assertiveness_assessment.is_challenging',
                                  'is_competitive' => '@assertiveness_assessment.is_competitive',
                                  'is_confronting' => '@assertiveness_assessment.is_confronting',
                                  'is_decisive' => '@assertiveness_assessment.is_decisive',
                                  'is_fast_paced' => '@assertiveness_assessment.is_fast_paced',
                                  'is_forthright' => '@assertiveness_assessment.is_forthright',
                                  'is_impatient' => '@assertiveness_assessment.is_impatient',
                                  'is_outspoken' => '@assertiveness_assessment.is_outspoken',
                                  'is_to_the_point' => '@assertiveness_assessment.is_to_the_point' }
    }

    assert_response :redirect

    assert_success_alert 'Assertiveness assessment was successfully updated.'
  end
end
