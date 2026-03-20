# frozen_string_literal: true

require 'test_helper'

class InquiryTest < ActiveSupport::TestCase
  test 'ready_to_submit? is true when all applicants have completed everything and inquiry details are present' do
    diagnostic_inquiry = inquiries(:medical_diagnostic_clinic)

    assert_predicate diagnostic_inquiry, :ready_to_submit?

    diagnostic_inquiry.applicants.first.stub :applicant_detail, nil do
      assert_not diagnostic_inquiry.ready_to_submit?
    end

    users(:charlie).update!(suv_application: diagnostic_inquiry.suv_application)

    assert_not diagnostic_inquiry.reload.ready_to_submit?
  end

  test 'cannot submit unless ready_to_submit?' do
    fitpal_inquiry = inquiries(:fitpal)

    set_fitpal_to_in_progress

    self.subject = fitpal_inquiry

    subject.update(submission_date: Time.zone.today, submission_full_name: 'Bob', submission_confirmed: true)

    users(:charlie).update!(suv_application: fitpal_inquiry.suv_application)

    subject.update(status: :submitted)

    assert_equal ['All applicants must complete applicant specific steps before submitting'],
                 subject.errors.full_messages

    users(:charlie).update!(suv_application: nil)

    subject.reload.update(status: :submitted)

    assert_empty subject.errors.full_messages
  end

  test 'can only be approved or declined if previous status was submitted' do
    self.subject = inquiries(:fitpal)
    message = 'can only be set to approved or declined if the previous status was submitted'
    subject.update_columns(status: 'approved')

    assert_invalid message, status: 'declined'

    subject.update_columns(status: 'declined')

    assert_invalid message, status: 'approved'

    subject.update_columns(status: 'in_progress')

    assert_invalid message, status: 'approved'
    assert_invalid message, status: 'declined'

    subject.update_columns(status: 'submitted')

    assert_valid status: 'approved'
    assert_valid status: 'declined'
  end

  test 'other_business_industry is required if business industry includes other' do
    assert_valid other_business_industry: nil
    subject.business_industry = 'Other'

    assert_invalid "can't be blank", other_business_industry: nil
    assert_valid other_business_industry: 'Techy'
  end

  test 'area_of_expertise and which_industries_excite_you cannot be greater than 5 chosen options' do
    assert_invalid 'cannot be more than 5 choices.', area_of_expertise: ['', 1, 2, 3, 4, 5, 6]
    assert_valid area_of_expertise: ['', 1, 2, 3, 4, 5]

    assert_invalid 'cannot be more than 5 choices.', which_industries_excite_you: ['', 1, 2, 3, 4, 5, 6]
    assert_valid which_industries_excite_you: ['', 1, 2, 3, 4, 5]
  end

  test 'must provide a reason when declining' do
    subject.status = :declined

    assert_invalid "can't be blank", decline_reason: nil

    subject.status = :in_progress

    assert_valid decline_reason: nil
  end

  test 'removes decline reason when submitting again' do
    fitpal_inquiry = inquiries(:fitpal)

    fitpal_inquiry.update_columns(status: :decline, decline_reason: 'not a good idea')

    fitpal_inquiry.update!(status: :submitted)

    assert_nil fitpal_inquiry.reload.decline_reason
  end
end
