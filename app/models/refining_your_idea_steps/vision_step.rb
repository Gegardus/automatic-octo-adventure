# frozen_string_literal: true

module RefiningYourIdeaSteps
  # Step for capturing applicants vision
  class VisionStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant

    def completed?
      skipped? || applicant.refining_your_idea_module&.vision_step_completed?
    end

    def step_name
      :vision
    end

    def next_step_name
      :values
    end

    def previous_step_name
      :mission
    end
  end
end
