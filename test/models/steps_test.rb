# frozen_string_literal: true

require 'test_helper'

class StepsTest < ActiveSupport::TestCase
  test 'last_step, next_step and previous_step' do # rubocop:disable Metrics/BlockLength
    bob = users(:bob)

    self.subject = PreIncubation.new(applicant: bob).steps_for_applicant

    applicant_detail_step = subject.step_for_step_name(:applicant_detail)
    applicant_education_record_step = subject.step_for_step_name(:applicant_education_record)
    applicant_work_experience_step = subject.step_for_step_name(:applicant_work_experience)
    applicant_skill_step = subject.step_for_step_name(:applicant_skill)
    inquiry_additional_information_step = subject.step_for_step_name(:additional_information)
    your_interest_step = subject.step_for_step_name(:your_interest)
    inquiry_confirmation_step = subject.step_for_step_name(:confirmation)

    assert_predicate subject, :completed?

    subject.current_step = applicant_detail_step

    assert_nil subject.previous_step
    assert_equal applicant_education_record_step, subject.next_step

    subject.current_step = applicant_education_record_step

    assert_equal applicant_detail_step, subject.previous_step
    assert_equal applicant_work_experience_step, subject.next_step

    subject.current_step = applicant_work_experience_step

    assert_equal applicant_education_record_step, subject.previous_step
    assert_equal applicant_skill_step, subject.next_step

    subject.current_step = applicant_skill_step

    assert_equal applicant_work_experience_step, subject.previous_step
    assert_equal inquiry_additional_information_step, subject.next_step

    subject.current_step = inquiry_additional_information_step

    assert_equal applicant_skill_step, subject.previous_step
    assert_equal your_interest_step, subject.next_step

    subject.current_step = your_interest_step

    assert_equal inquiry_additional_information_step, subject.previous_step
    assert_equal inquiry_confirmation_step, subject.next_step

    subject.current_step = inquiry_confirmation_step

    assert_equal your_interest_step, subject.previous_step
    assert_nil subject.next_step
  end

  test 'next_step_available? is only true when current step and all previous steps are completed' do
    bob = users(:bob)

    not_completed_applicant_detail_step = InquirySteps::ApplicantDetailStep.new(applicant: bob)
    completed_applicant_detail_step = InquirySteps::ApplicantDetailStep.new(applicant: bob)
    applicant_education_record_step = InquirySteps::ApplicantEducationRecordStep.new(applicant: bob)

    subject.all_steps = [
      not_completed_applicant_detail_step,
      applicant_education_record_step
    ]

    subject.current_step = not_completed_applicant_detail_step

    bob.stub :applicant_detail, nil do
      assert_not subject.next_step_available?
    end

    subject.all_steps = [
      completed_applicant_detail_step,
      applicant_education_record_step
    ]

    subject.current_step = completed_applicant_detail_step

    bob.stub :applicant_education_records, [] do
      assert_predicate subject, :next_step_available?
    end
  end

  test '#current_available_step' do
    bob = users(:bob)
    applicant_detail_step = InquirySteps::ApplicantDetailStep.new(applicant: bob)
    applicant_education_record_step = InquirySteps::ApplicantEducationRecordStep.new(applicant: bob)
    not_completed_confirmation_step = InquirySteps::ConfirmationStep.new(applicant: bob)
    bob.inquiry.update(submission_confirmed: false, submission_date: nil, submission_full_name: '',
                       status: 'in_progress')

    subject.all_steps = [
      applicant_detail_step,
      applicant_education_record_step,
      not_completed_confirmation_step
    ]

    assert_equal not_completed_confirmation_step, subject.current_available_step
  end
end
