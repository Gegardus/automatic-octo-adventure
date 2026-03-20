# frozen_string_literal: true

module ImmigrationSteps
  # Step for getting information about Canada
  class HelpfulTipsStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant

    def completed?
      skipped? || applicant.immigration_module.present?
    end

    def step_name
      :helpful_tips
    end

    def next_step_name
      :final_quiz
    end

    def previous_step_name
      :education
    end
  end
end
