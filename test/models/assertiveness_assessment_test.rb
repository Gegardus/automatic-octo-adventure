# frozen_string_literal: true

require 'test_helper'

class AssertivenessAssessmentTest < ActiveSupport::TestCase
  test '#calculate_score returns the correct score' do
    self.subject = assertiveness_assessments(:bobs_drive)

    assert subject.is_bold

    assert_equal 7, subject.score

    subject.is_bold = false

    assert_equal 6, subject.score
  end
end
