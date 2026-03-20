# frozen_string_literal: true

require 'test_helper'

class RefiningYourIdeaTest < ActiveSupport::TestCase
  test '#steps_for_applicant' do # rubocop:disable Metrics/BlockLength
    bob = users(:bob)
    bob.update!(refining_your_idea_module: RefiningYourIdeaModule.create!)

    refining_your_idea_module = bob.refining_your_idea_module

    subject.applicant = bob

    steps = subject.steps_for_applicant

    your_idea = steps.step_for_step_name(:your_idea)
    mission = steps.step_for_step_name(:mission)
    vision = steps.step_for_step_name(:vision)
    values = steps.step_for_step_name(:values)
    value_proposition = steps.step_for_step_name(:value_proposition)
    goals = steps.step_for_step_name(:goals)

    steps.current_step = your_idea

    refining_your_idea_module.stub :your_idea_step_completed?, true do
      assert_equal mission, steps.next_step
      assert_nil steps.previous_step
      assert_predicate steps.current_step, :completed?
    end

    steps.current_step = mission

    refining_your_idea_module.stub :mission_step_completed?, true do
      assert_equal vision, steps.next_step
      assert_equal your_idea, steps.previous_step
      assert_predicate steps.current_step, :completed?
    end

    steps.current_step = vision

    refining_your_idea_module.stub :vision_step_completed?, true do
      assert_equal values, steps.next_step
      assert_equal mission, steps.previous_step
      assert_predicate steps.current_step, :completed?
    end

    steps.current_step = values

    refining_your_idea_module.stub :values_step_completed?, true do
      assert_equal value_proposition, steps.next_step
      assert_equal vision, steps.previous_step
      assert_predicate steps.current_step, :completed?
    end

    steps.current_step = value_proposition

    refining_your_idea_module.stub :value_proposition_step_completed?, true do
      assert_equal goals, steps.next_step
      assert_equal values, steps.previous_step
      assert_predicate steps.current_step, :completed?
    end

    steps.current_step = goals

    refining_your_idea_module.stub :goals_step_completed?, true do
      assert_nil steps.next_step
      assert_equal value_proposition, steps.previous_step
      assert_predicate steps.current_step, :completed?
    end
  end
end
