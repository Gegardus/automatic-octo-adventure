# frozen_string_literal: true

require 'test_helper'

class SkippedStepsControllerTest < ActionDispatch::IntegrationTest
  setup do
    given_signed_in_as :dom
  end

  test '#index' do
    get skipped_steps_path

    assert_response :success
    assert_text 'Skipped steps'
  end

  test '#new' do
    get new_skipped_step_path

    assert_response :success
    assert_text 'New skipped step'
  end

  test '#create' do
    suv_application = suv_applications(:fitpal_application)

    assert_difference 'SkippedStep.count', 1 do
      post skipped_steps_path, params: {
        multiple_skipped_steps: {
          steps_to_skip: ['applicant_detail'],
          suv_application_id: suv_application.id,
          module_name: 'pre_incubation'
        }
      }
    end

    assert_response :redirect
    assert_success_alert 'Skipped step was successfully created.'
  end

  test '#destroy' do
    skipped_step = skipped_steps(:jim_applicant_detail_skipped)

    assert_difference 'SkippedStep.count', -1 do
      delete skipped_step_path(skipped_step)
    end
  end
end
