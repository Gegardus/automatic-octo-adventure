# frozen_string_literal: true

module InquirySteps
  # Step for collecting inquiry specific details
  class ConfirmationStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant

    delegate :inquiry, to: :applicant
    delegate :submission_confirmed,
             :submission_date,
             :submission_full_name, to: :inquiry

    def completed?
      skipped? || (submission_date.present? && submission_full_name.present? && submission_confirmed)
    end

    def step_name
      :confirmation
    end

    def next_step_name
      nil
    end

    def previous_step_name
      :your_interest
    end
  end
end
