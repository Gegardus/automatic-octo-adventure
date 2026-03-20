# frozen_string_literal: true

module QuickAssessmentSteps
  # Step for collecting quick assessment specific details
  class IntroductionStep
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
      :introduction
    end

    def next_step_name
      :assertiveness_assessment
    end

    def previous_step_name
      nil
    end
  end
end
