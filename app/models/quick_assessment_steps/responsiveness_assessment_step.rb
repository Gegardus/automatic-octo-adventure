# frozen_string_literal: true

module QuickAssessmentSteps
  # Step for collecting quick assessment specific details
  class ResponsivenessAssessmentStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant

    delegate :responsiveness_assessment, to: :applicant

    def completed?
      skipped? || responsiveness_assessment.present?
    end

    def step_name
      :responsiveness_assessment
    end

    def next_step_name
      :results
    end

    def previous_step_name
      :assertiveness_assessment
    end
  end
end
