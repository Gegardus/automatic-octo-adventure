# frozen_string_literal: true

require 'test_helper'

class BusinessModelTest < ActiveSupport::TestCase
  test 'presence validations' do
    business_model = BusinessModel.create!(suv_application: suv_applications(:medical_diagnostic_clinic_application))

    self.subject = business_model

    subject.current_step = 'building_business_plan'

    attributes_to_exclude = %w[share_canvas_learnings share_swot_learnings share_forces_learnings]
    remaining_attributes = subject.class::BUILDING_BUSINESS_ATTRS.reject { |attr| attributes_to_exclude.include?(attr) }

    remaining_attributes.each do |attr|
      assert_invalid "can't be blank", "#{attr}": nil
      subject.send("#{attr}=", 'some value')
    end

    attributes_to_exclude.each do |attr|
      assert_invalid "can't be blank", "#{attr}": nil
      subject.send("#{attr}=", Rack::Test::UploadedFile.new('test/fixtures/files/placeholder.jpeg', 'image/jpeg'))
    end

    subject.current_step = 'business_plan'

    subject.class::BUSINESS_PLAN_ATTRS.each do |attr|
      assert_invalid "can't be blank", "#{attr}": nil
      subject.send("#{attr}=", 'some value')
    end
  end

  test 'steps_for_applicant' do
    bob = users(:bob)

    subject.applicant = bob

    steps = subject.steps_for_applicant

    assert_equal 'Module 7: The Business Model', steps.title

    getting_started = steps.step_for_step_name(:getting_started_with_business_plan)
    building_business_plan = steps.step_for_step_name(:building_business_plan)
    business_plan = steps.step_for_step_name(:business_plan)

    steps.current_step = getting_started

    assert_equal building_business_plan, steps.next_step
    assert_nil steps.previous_step
    assert_not_predicate steps.current_step, :completed?

    steps.current_step = building_business_plan

    assert_equal business_plan, steps.next_step
    assert_equal getting_started, steps.previous_step
    assert_not_predicate steps.current_step, :completed?

    steps.current_step = business_plan

    assert_nil steps.next_step
    assert_equal building_business_plan, steps.previous_step
    assert_not_predicate steps.current_step, :completed?
  end

  test '#building_business_plan_step_complete?, #business_plan_step_complete?, #passed?' do
    business_model = BusinessModel.new

    assert_not business_model.building_business_plan_step_complete?
    assert_not business_model.business_plan_step_complete?
    assert_not business_model.passed?

    business_model = business_models(:better_health_startup)

    business_model.share_canvas_learnings = Rack::Test::UploadedFile.new('test/fixtures/files/placeholder.jpeg',
                                                                         'image/jpeg')
    business_model.share_swot_learnings = Rack::Test::UploadedFile.new('test/fixtures/files/placeholder.jpeg',
                                                                       'image/jpeg')
    business_model.share_forces_learnings = Rack::Test::UploadedFile.new('test/fixtures/files/placeholder.jpeg',
                                                                         'image/jpeg')
    business_model.save

    assert_predicate business_model, :building_business_plan_step_complete?
    assert_predicate business_model, :business_plan_step_complete?
    assert_predicate business_model, :passed?
  end
end
