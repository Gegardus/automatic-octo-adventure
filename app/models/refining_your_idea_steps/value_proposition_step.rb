# frozen_string_literal: true

module RefiningYourIdeaSteps
  # Step for capturing applicants value proposition
  class ValuePropositionStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant

    def completed?
      skipped? || applicant.refining_your_idea_module&.value_proposition_step_completed?
    end

    def step_name
      :value_proposition
    end

    def next_step_name
      :goals
    end

    def previous_step_name
      :values
    end
  end
end
