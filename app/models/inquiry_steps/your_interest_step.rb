# frozen_string_literal: true

module InquirySteps
  # Step for collecting applicant interest
  class YourInterestStep
    extend Interfaceable
    include ActiveModel::Model
    include ActiveModel::Attributes
    include SkippableSteps

    implements Step

    attribute :applicant
    delegate :inquiry, to: :applicant
    delegate :existing_business_idea,
             :position,
             :area_of_expertise, to: :inquiry, allow_nil: true

    def completed?
      skipped? || (existing_business_idea && position.present?) ||
        (!existing_business_idea && area_of_expertise.present?)
    end

    def step_name
      :your_interest
    end

    def next_step_name
      :confirmation
    end

    def previous_step_name
      :additional_information
    end
  end
end
