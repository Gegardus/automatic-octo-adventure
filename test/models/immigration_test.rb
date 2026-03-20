# frozen_string_literal: true

require 'test_helper'

class ImmigrationTest < ActiveSupport::TestCase
  test '#steps_for_applicant' do # rubocop:disable Metrics/BlockLength
    bob = users(:bob)

    subject.applicant = bob
    subject.applicant

    steps = subject.steps_for_applicant

    basic_info = steps.step_for_step_name(:basic_info)
    startup = steps.step_for_step_name(:startup)
    legal = steps.step_for_step_name(:legal)
    housing = steps.step_for_step_name(:housing)
    education = steps.step_for_step_name(:education)
    helpful_tips = steps.step_for_step_name(:helpful_tips)
    final_quiz = steps.step_for_step_name(:final_quiz)

    steps.current_step = basic_info

    assert_equal startup, steps.next_step
    assert_nil steps.previous_step
    assert_predicate steps.current_step, :completed?

    steps.current_step = startup

    assert_equal legal, steps.next_step
    assert_equal basic_info, steps.previous_step
    assert_predicate steps.current_step, :completed?

    steps.current_step = legal

    assert_equal housing, steps.next_step
    assert_equal startup, steps.previous_step
    assert_predicate steps.current_step, :completed?

    steps.current_step = housing

    assert_equal education, steps.next_step
    assert_equal legal, steps.previous_step
    assert_predicate steps.current_step, :completed?

    steps.current_step = education

    assert_equal helpful_tips, steps.next_step
    assert_equal housing, steps.previous_step
    assert_predicate steps.current_step, :completed?

    steps.current_step = helpful_tips

    assert_equal final_quiz, steps.next_step
    assert_equal education, steps.previous_step
    assert_predicate steps.current_step, :completed?

    steps.current_step = final_quiz

    assert_nil steps.next_step
    assert_equal helpful_tips, steps.previous_step
    subject.applicant.current_immigration_quiz.stub(:passed?, true) do
      assert_predicate steps.current_step, :completed?
    end
  end
end
