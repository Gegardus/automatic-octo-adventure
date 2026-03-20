# frozen_string_literal: true

module QuickAssessmentSteps
  # Step for collecting quick assessment specific details
  class AssertivenessAssessmentStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant

    delegate :assertiveness_assessment, to: :applicant

    def completed?
      skipped? || assertiveness_assessment.present?
    end

    def step_name
      :assertiveness_assessment
    end

    def next_step_name
      :responsiveness_assessment
    end

    def previous_step_name
      :introduction
    end
  end
end
