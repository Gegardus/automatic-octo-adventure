# frozen_string_literal: true

module QuickAssessmentSteps
  # Step for collecting quick assessment specific details
  class ResultsStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant

    delegate :assertiveness_assessment, :responsiveness_assessment, to: :applicant

    def completed?
      skipped? || (assertiveness_assessment.present? && responsiveness_assessment.present?)
    end

    def step_name
      :results
    end

    def next_step_name
      nil
    end

    def previous_step_name
      :responsiveness_assessment
    end
  end
end
