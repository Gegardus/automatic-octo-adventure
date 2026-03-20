# frozen_string_literal: true

module RefiningYourIdeaSteps
  # Step for capturing applicants idea
  class YourIdeaStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant

    def completed?
      skipped? || applicant.refining_your_idea_module&.your_idea_step_completed?
    end

    def step_name
      :your_idea
    end

    def next_step_name
      :mission
    end

    def previous_step_name
      nil
    end
  end
end
