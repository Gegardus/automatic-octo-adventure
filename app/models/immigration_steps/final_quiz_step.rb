# frozen_string_literal: true

module ImmigrationSteps
  # Step for getting information about Canada
  class FinalQuizStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant

    def completed?
      skipped? || applicant.current_immigration_quiz&.passed?
    end

    def step_name
      :final_quiz
    end

    def next_step_name
      nil
    end

    def previous_step_name
      :helpful_tips
    end
  end
end
