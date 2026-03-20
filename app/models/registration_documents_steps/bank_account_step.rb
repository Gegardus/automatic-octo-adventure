# frozen_string_literal: true

module RegistrationDocumentsSteps
  # Step for creating bank account
  class BankAccountStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant

    def completed?
      skipped? || applicant.suv_application.bank_account_document.attached?
    end

    def step_name
      :bank_account
    end

    def next_step_name
      nil
    end

    def previous_step_name
      :online_registration
    end
  end
end
