# frozen_string_literal: true

require 'test_helper'

class SuvApplicationTest < ActiveSupport::TestCase
  test 'validations' do
    assert_invalid "can't be blank", team_name: nil
    assert_valid team_name: 'Vanguard'
    existing_team_name = suv_applications(:fitpal_application).team_name

    assert_invalid 'has already been taken', team_name: existing_team_name

    assert_valid team_name: "#{existing_team_name}-new"
  end

  test 'ransackable_attributes' do
    assert_equal ['team_name'], subject.class.ransackable_attributes
  end

  test 'applicant_names' do
    fitpal_application = suv_applications(:fitpal_application)

    assert_equal 'Bob Dole', fitpal_application.applicant_names
  end
end
