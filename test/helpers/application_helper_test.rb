# frozen_string_literal: true

require 'test_helper'
class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper

  test '#module_step_path_for' do
    step = OpenStruct.new(step_name: :applicant_detail)
    path = module_step_path_for(:pre_incubation, step.step_name)

    assert_equal inquiry_steps_applicant_detail_path, path

    step = OpenStruct.new(step_name: :additional_information)
    path = module_step_path_for(:pre_incubation, step.step_name)

    assert_equal edit_inquiry_steps_additional_informations_path, path

    step = OpenStruct.new(step_name: :confirmation)
    path = module_step_path_for(:pre_incubation, step.step_name)

    assert_equal edit_inquiry_steps_confirmations_path, path

    step = OpenStruct.new(step_name: :applicant_skill)
    path = module_step_path_for(:pre_incubation, step.step_name)

    assert_equal inquiry_steps_applicant_skills_path, path
  end
end
