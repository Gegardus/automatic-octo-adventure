# frozen_string_literal: true

require 'test_helper'

class RegistrationDocumentsTest < ActiveSupport::TestCase
  test 'steps_for_applicant' do
    bob = users(:bob)

    subject.applicant = bob

    steps = subject.steps_for_applicant

    assert_equal 'Module 3: Legal, Taxation & Incorporation', steps.title

    register_business = steps.step_for_step_name(:register_business)
    online_registration = steps.step_for_step_name(:online_registration)
    bank_account = steps.step_for_step_name(:bank_account)

    steps.current_step = register_business

    assert_equal online_registration, steps.next_step
    assert_nil steps.previous_step
    assert_not_predicate steps.current_step, :completed?

    steps.current_step = online_registration

    assert_equal bank_account, steps.next_step
    assert_equal register_business, steps.previous_step
    assert_not_predicate steps.current_step, :completed?

    steps.current_step = bank_account

    assert_nil steps.next_step
    assert_equal online_registration, steps.previous_step
    assert_not_predicate steps.current_step, :completed?
  end
end
