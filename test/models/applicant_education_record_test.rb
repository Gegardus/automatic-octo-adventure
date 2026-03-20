# frozen_string_literal: true

require 'test_helper'

class ApplicantEducationRecordTest < ActiveSupport::TestCase
  test 'validations' do
    assert_invalid "can't be blank", degree_type: nil
    assert_invalid "can't be blank", institution_name: nil
    assert_invalid "can't be blank", concentration: nil
    assert_invalid "can't be blank", start_date: nil
    assert_invalid "can't be blank", end_date: nil

    assert_valid degree_type: 'Graduate'
    assert_valid institution_name: 'Yale'
    assert_valid concentration: 'Economics - Mathematics'
    assert_valid start_date: '2015-09-01'
    assert_valid end_date: '2019-09-01'
    assert_valid graduated: false
  end
end
