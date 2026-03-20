# frozen_string_literal: true

module BusinessModelSteps
  # Step for building applicants business plan
  class BuildingBusinessPlanStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant

    def completed?
      skipped? || applicant.business_model&.building_business_plan_step_complete?
    end

    def step_name
      :building_business_plan
    end

    def next_step_name
      :business_plan
    end

    def previous_step_name
      :getting_started_with_business_plan
    end
  end
end
