# frozen_string_literal: true

require 'test_helper'

class ApplicantSkillTest < ActiveSupport::TestCase
  test 'validations' do
    assert_invalid "can't be blank", description: nil
    assert_invalid "can't be blank", proficiency_level: nil
    assert_invalid "can't be blank", skill_type: nil
    assert_invalid "can't be blank", certification: nil

    assert_valid description: 'Talking to cats'
    assert_valid proficiency_level: 'expert'
    assert_valid skill_type: 'Talking to cats'
    assert_valid certification: 'Advance'
  end
end
