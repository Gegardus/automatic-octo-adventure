# frozen_string_literal: true

require 'test_helper'

class ApplicationModulesTest < ActiveSupport::TestCase
  test 'module_active?' do
    bob = users(:bob)
    subject.applicant = bob

    set_fitpal_to_in_progress

    assert_equal 'in_progress', bob.inquiry.status
    assert_not subject.pre_incubation_steps.completed?
    assert subject.module_active?(:pre_incubation)
    assert_not subject.module_active?(:quick_assessment)
  end

  test 'all the modules steps' do
    bob = users(:bob)
    subject.applicant = bob

    assert_instance_of(Steps, subject.pre_incubation_steps)
    assert_instance_of(Steps, subject.quick_assessment_steps)
    assert_instance_of(Steps, subject.immigration_module_steps)
    assert_instance_of(Steps, subject.refining_your_idea_steps)
    assert_instance_of(Steps, subject.registration_documents_steps)
    assert_instance_of(Steps, subject.business_model_steps)
  end

  test '#progress_percentage' do
    jim = users(:jim)
    subject.applicant = jim

    assert_in_delta(7, subject.progress_percentage)
  end

  test 'ben has completed all modules' do
    ben = users(:ben)
    subject.applicant = ben

    ApplicationModules::MODULES.each do |mod|
      assert_predicate subject.send("#{mod}_steps"), :completed?, "Expected ben to have completed the #{mod} module"
    end
  end

  test '#steps_for_module' do
    assert_equal %i[applicant_detail applicant_education_record applicant_work_experience
                    applicant_skill additional_information your_interest confirmation],
                 ApplicationModules.steps_for_module(:pre_incubation).all_steps.map(&:step_name)
  end
end
