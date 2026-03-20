# frozen_string_literal: true

# All sections for business registeration docs
class RegistrationDocuments
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :applicant

  def steps_for_applicant
    Steps.new(
      title: 'Module 3: Legal, Taxation & Incorporation',
      all_steps: [
        RegistrationDocumentsSteps::RegisterBusinessStep.new(applicant: applicant),
        RegistrationDocumentsSteps::OnlineRegistrationStep.new(applicant: applicant),
        RegistrationDocumentsSteps::BankAccountStep.new(applicant: applicant)
      ]
    )
  end
end
