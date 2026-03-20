# frozen_string_literal: true

require 'test_helper'

class ApplicantWorkExperienceTest < ActiveSupport::TestCase
  test 'validations' do
    assert_invalid "can't be blank", company: nil
    assert_invalid "can't be blank", job_title: nil
    assert_invalid "can't be blank", responsibilities: nil
    assert_invalid "can't be blank", tenure: nil
    assert_invalid "can't be blank", location: nil

    assert_valid company: 'Detroit Delivery'
    assert_valid job_title: 'Manager'
    assert_valid responsibilities: 'Lead, mentor, and manage a team of associates.'
    assert_valid tenure: 'Two years'
    assert_valid location: 'Detroit'
  end
end
