# frozen_string_literal: true

module RegistrationDocumentsSteps
  # Step for business registration
  class RegisterBusinessStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant

    def completed?
      skipped? || applicant.suv_application&.online_registration_document&.attached?
    end

    def step_name
      :register_business
    end

    def next_step_name
      :online_registration
    end

    def previous_step_name
      nil
    end
  end
end
