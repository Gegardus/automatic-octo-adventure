# frozen_string_literal: true

require 'test_helper'

class ResponsivenessAssessmentTest < ActiveSupport::TestCase
  test '#calculate_score returns the correct score' do
    self.subject = responsiveness_assessments(:bobs_sensitivity)

    assert subject.is_open

    assert_equal 5, subject.score

    subject.is_open = false

    assert_equal 4, subject.score
  end
end
