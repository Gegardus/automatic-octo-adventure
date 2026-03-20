# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#active_for_authentication' do
    active_user = users(:bob)
    inactive_user = users(:john)

    assert_predicate active_user, :active_for_authentication?
    assert_not_predicate inactive_user, :active_for_authentication?
  end

  test 'all types of user validation' do
    subject.role = 'admin'

    assert_invalid "can't be blank", first_name: nil
    assert_invalid "can't be blank", last_name: nil
    assert_invalid "can't be blank", email: nil
    assert_invalid "can't be blank", password: nil

    assert_valid first_name: 'Bob'
    assert_valid last_name: 'Smith'
    assert_valid email: 'dick@test.com'
    assert_valid password: 'password123'
    assert_valid phone: nil
    assert_valid date_of_birth: nil

    subject.email = 'dick@test.com'
    subject.password = 'password123'

    assert_invalid "doesn't match Password", password_confirmation: 'password321'
    assert_valid password_confirmation: 'password123'
  end

  test 'applicant validations' do
    subject.role = 'applicant'

    assert_invalid "can't be blank", phone: nil
    assert_invalid "can't be blank", date_of_birth: nil

    assert_valid phone: '12345'
    assert_valid date_of_birth: Date.new
  end

  test '#full_name' do
    assert_equal 'Bob Dole', users(:bob).full_name
  end

  test '#self.ransackable_attributes' do
    expected_attributes = %w[first_name last_name email]

    actual_attributes = User.ransackable_attributes

    assert_equal expected_attributes, actual_attributes
  end

  test '#self.ransackable_associations' do
    expected_associations = %w[suv_application]

    actual_associations = User.ransackable_associations

    assert_equal expected_associations, actual_associations
  end

  test '#team_name' do
    suv_application = SuvApplication.new(team_name: 'Test Team')
    applicant = User.new(suv_application: suv_application)

    assert_equal 'Test Team', applicant.team_name
  end
end
