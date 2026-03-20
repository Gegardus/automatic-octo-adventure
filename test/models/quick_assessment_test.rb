# frozen_string_literal: true

require 'test_helper'

class QuickAssessmentTest < ActiveSupport::TestCase
  test 'steps_for_applicant' do
    bob = users(:bob)

    subject.applicant = bob

    steps = subject.steps_for_applicant

    assert_equal 'Quick assessment', steps.title

    introduction = steps.step_for_step_name(:introduction)
    assertivness_assessment = steps.step_for_step_name(:assertiveness_assessment)
    responsiveness_assessment = steps.step_for_step_name(:responsiveness_assessment)
    results = steps.step_for_step_name(:results)

    steps.current_step = introduction

    assert_equal assertivness_assessment, steps.next_step
    assert_nil steps.previous_step
    assert_predicate steps.current_step, :completed?

    steps.current_step = assertivness_assessment

    assert_equal responsiveness_assessment, steps.next_step
    assert_equal introduction, steps.previous_step
    assert_predicate steps.current_step, :completed?

    steps.current_step = responsiveness_assessment

    assert_equal results, steps.next_step
    assert_equal assertivness_assessment, steps.previous_step
    assert_predicate steps.current_step, :completed?

    steps.current_step = results

    assert_nil steps.next_step
    assert_equal responsiveness_assessment, steps.previous_step
    assert_predicate steps.current_step, :completed?
  end

  test 'analytical?' do
    subject.stub :assertiveness_assessment_score, 4 do
      subject.stub :responsiveness_assessment_score, 4 do
        assert_predicate subject, :analytical?
        assert_not subject.driver?
        assert_not subject.expressive?
        assert_not subject.amiable?
      end
    end
  end

  test 'driver?' do
    subject.stub :assertiveness_assessment_score, 6 do
      subject.stub :responsiveness_assessment_score, 4 do
        assert_not subject.analytical?
        assert_predicate subject, :driver?
        assert_not subject.expressive?
        assert_not subject.amiable?
      end
    end
  end

  test 'expressive?' do
    subject.stub :assertiveness_assessment_score, 6 do
      subject.stub :responsiveness_assessment_score, 6 do
        assert_not subject.analytical?
        assert_not subject.driver?
        assert_predicate subject, :expressive?
        assert_not subject.amiable?
      end
    end
  end

  test 'amiable?' do
    subject.stub :assertiveness_assessment_score, 4 do
      subject.stub :responsiveness_assessment_score, 6 do
        assert_not subject.analytical?
        assert_not subject.driver?
        assert_not subject.expressive?
        assert_predicate subject, :amiable?
      end
    end
  end

  test 'analytical_driver?' do
    subject.stub :assertiveness_assessment_score, 5 do
      subject.stub :responsiveness_assessment_score, 3 do
        assert_not subject.expressive?
        assert_not subject.amiable?
        assert_predicate subject, :analytical?
        assert_predicate subject, :driver?
      end
    end
  end

  test 'amiable_expressive?' do
    subject.stub :assertiveness_assessment_score, 5 do
      subject.stub :responsiveness_assessment_score, 6 do
        assert_not subject.analytical?
        assert_not subject.driver?
        assert_predicate subject, :expressive?
        assert_predicate subject, :amiable?
      end
    end
  end

  test 'analytical_amiable?' do
    subject.stub :assertiveness_assessment_score, 4 do
      subject.stub :responsiveness_assessment_score, 5 do
        assert_not subject.driver?
        assert_not subject.expressive?
        assert_predicate subject, :analytical?
        assert_predicate subject, :amiable?
      end
    end
  end

  test 'driver_expressive?' do
    subject.stub :assertiveness_assessment_score, 6 do
      subject.stub :responsiveness_assessment_score, 5 do
        assert_not subject.analytical?
        assert_not subject.amiable?
        assert_predicate subject, :driver?
        assert_predicate subject, :expressive?
      end
    end
  end

  test 'perfective?' do
    subject.stub :assertiveness_assessment_score, 5 do
      subject.stub :responsiveness_assessment_score, 5 do
        assert_predicate subject, :analytical?
        assert_predicate subject, :amiable?
        assert_predicate subject, :expressive?
        assert_predicate subject, :expressive?
      end
    end
  end
end
