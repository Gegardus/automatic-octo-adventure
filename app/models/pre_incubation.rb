# frozen_string_literal: true

# Encapsulates everything for pre incubation steps
class PreIncubation
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :applicant

  def steps_for_applicant # rubocop:disable Metrics/MethodLength
    Steps.new(
      title: 'Pre-incubation',
      all_steps: [
        InquirySteps::ApplicantDetailStep.new(applicant: applicant),
        InquirySteps::ApplicantEducationRecordStep.new(applicant: applicant),
        InquirySteps::ApplicantWorkExperienceStep.new(applicant: applicant),
        InquirySteps::ApplicantSkillStep.new(applicant: applicant),
        InquirySteps::AdditionalInformationStep.new(applicant: applicant),
        InquirySteps::YourInterestStep.new(applicant: applicant),
        InquirySteps::ConfirmationStep.new(applicant: applicant)
      ]
    )
  end
end
