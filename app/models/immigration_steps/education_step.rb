# frozen_string_literal: true

module ImmigrationSteps
  # Step for getting information about Canada
  class EducationStep
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
      :education
    end

    def next_step_name
      :helpful_tips
    end

    def previous_step_name
      :housing
    end
  end
end
