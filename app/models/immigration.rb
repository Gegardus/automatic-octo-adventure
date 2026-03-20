# frozen_string_literal: true

# Encapsulates pages for immigrations tips and rules
class Immigration
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :applicant

  def steps_for_applicant # rubocop:disable Metrics/MethodLength
    Steps.new(
      title: 'Start: Welcome to Canada',
      all_steps: [
        ImmigrationSteps::BasicInfoStep.new(applicant: applicant),
        ImmigrationSteps::StartupStep.new(applicant: applicant),
        ImmigrationSteps::LegalStep.new(applicant: applicant),
        ImmigrationSteps::HousingStep.new(applicant: applicant),
        ImmigrationSteps::EducationStep.new(applicant: applicant),
        ImmigrationSteps::HelpfulTipsStep.new(applicant: applicant),
        ImmigrationSteps::FinalQuizStep.new(applicant: applicant)
      ]
    )
  end
end
