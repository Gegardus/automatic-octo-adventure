# frozen_string_literal: true

module InquirySteps
  # Step for collecting applicant details during an inquiry
  class ApplicantDetailStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant

    delegate :suv_application, :applicant_detail, to: :applicant

    def completed?
      skipped? || applicant_detail&.persisted?
    end

    def step_name
      :applicant_detail
    end

    def next_step_name
      :applicant_education_record
    end

    def previous_step_name
      nil
    end
  end
end
