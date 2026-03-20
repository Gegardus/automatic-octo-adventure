# frozen_string_literal: true

module InquirySteps
  # Step for collecting inquiry specific details
  class AdditionalInformationStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant

    delegate :inquiry, to: :applicant
    delegate :reason_for_interest,
             :where_did_you_hear_about_us,
             :startup_location, :suv_application, to: :inquiry

    def completed?
      # TODO: think about the true here
      skipped? || true
    end

    def step_name
      :additional_information
    end

    def next_step_name
      :your_interest
    end

    def previous_step_name
      :applicant_skill
    end
  end
end
