# frozen_string_literal: true

module InquirySteps
  # Step for collecting applicant experience
  class ApplicantWorkExperienceStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant
    delegate :applicant_work_experiences, to: :applicant

    def completed?
      skipped? || applicant_work_experiences.any?
    end

    def step_name
      :applicant_work_experience
    end

    def next_step_name
      :applicant_skill
    end

    def previous_step_name
      :applicant_education_record
    end
  end
end
