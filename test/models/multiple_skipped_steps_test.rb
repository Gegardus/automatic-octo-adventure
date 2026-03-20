# frozen_string_literal: true

require 'test_helper'

class MultipleSkippedStepTest < ActiveSupport::TestCase
  test 'cleans up existing skipped steps when new ones are created' do # rubocop:disable Metrics/BlockLength
    fitpal = suv_applications(:fitpal_application)
    bob = users(:bob)
    skipped_for_application = SkippedStep.create!(
      suv_application: fitpal,
      step_name: :applicant_detail,
      module_name: :pre_incubation
    )

    skipped_for_user = SkippedStep.create!(
      user: bob,
      step_name: :applicant_detail,
      module_name: :pre_incubation
    )

    assert_not InquirySteps::ApplicantWorkExperienceStep.new(applicant: bob).skipped?

    assert MultipleSkippedSteps.new(
      suv_application_id: fitpal.id,
      module_name: :pre_incubation,
      steps_to_skip: %i[applicant_detail applicant_education_record]
    ).save

    assert_not SkippedStep.exists?(skipped_for_application.id)
    assert_not SkippedStep.exists?(skipped_for_user.id)

    assert SkippedStep.find_by(
      suv_application: fitpal,
      step_name: :applicant_detail
    )

    assert SkippedStep.find_by(
      suv_application: fitpal,
      step_name: :applicant_education_record
    )
  end
end
