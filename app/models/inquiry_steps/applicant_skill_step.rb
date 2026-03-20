# frozen_string_literal: true

module InquirySteps
  # Step for collecting applicant skills
  class ApplicantSkillStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant
    delegate :applicant_skills, to: :applicant

    def completed?
      skipped? || applicant_skills.any?
    end

    def step_name
      :applicant_skill
    end

    def next_step_name
      :additional_information
    end

    def previous_step_name
      :applicant_work_experience
    end
  end
end
