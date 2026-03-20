# frozen_string_literal: true

module RefiningYourIdeaSteps
  # Step for capturing applicants mission
  class MissionStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant

    def completed?
      skipped? || applicant.refining_your_idea_module&.mission_step_completed?
    end

    def step_name
      :mission
    end

    def next_step_name
      :vision
    end

    def previous_step_name
      :your_idea
    end
  end
end
