# frozen_string_literal: true

module InquirySteps
  # Step for collecting applicant education records during an inquiry
  class ApplicantEducationRecordStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant
    delegate :applicant_education_records, to: :applicant

    def completed?
      skipped? || applicant_education_records.any?
    end

    def step_name
      :applicant_education_record
    end

    def next_step_name
      :applicant_work_experience
    end

    def previous_step_name
      :applicant_detail
    end
  end
end
