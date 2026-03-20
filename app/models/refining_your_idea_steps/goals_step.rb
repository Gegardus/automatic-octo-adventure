# frozen_string_literal: true

module RefiningYourIdeaSteps
  # Step for capturing applicants goal
  class GoalsStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant

    def completed?
      skipped? || applicant.refining_your_idea_module&.goals_step_completed?
    end

    def step_name
      :goals
    end

    def next_step_name
      nil
    end

    def previous_step_name
      :value_proposition
    end
  end
end
