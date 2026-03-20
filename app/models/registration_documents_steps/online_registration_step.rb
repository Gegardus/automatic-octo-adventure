# frozen_string_literal: true

module RegistrationDocumentsSteps
  # Step for online registration
  class OnlineRegistrationStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant

    def completed?
      skipped? || applicant.suv_application.online_registration_document.attached?
    end

    def step_name
      :online_registration
    end

    def next_step_name
      :bank_account
    end

    def previous_step_name
      :register_business
    end
  end
end
