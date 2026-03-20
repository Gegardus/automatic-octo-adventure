# frozen_string_literal: true

module RefiningYourIdeaSteps
  # Step for capturing applicants values
  class ValuesStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant

    def completed?
      skipped? || applicant.refining_your_idea_module&.values_step_completed?
    end

    def step_name
      :values
    end

    def next_step_name
      :value_proposition
    end

    def previous_step_name
      :vision
    end
  end
end
