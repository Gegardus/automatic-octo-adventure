# frozen_string_literal: true

module ImmigrationSteps
  # Step for getting information about Canada
  class StartupStep
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
      :startup
    end

    def next_step_name
      :legal
    end

    def previous_step_name
      :basic_info
    end
  end
end
