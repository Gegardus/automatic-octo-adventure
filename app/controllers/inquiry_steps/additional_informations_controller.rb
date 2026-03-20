# frozen_string_literal: true

module InquirySteps
  class AdditionalInformationsController < ApplicationController
    authorized_when { current_user.applicant? }
    include StepsForInquiry
    before_action -> { setup_inquiry_for_step(:additional_information) }

    def update
      @inquiry.update(inquiry_params)

      respond_with @inquiry, location: inquiry_steps_additional_informations_path
    end

    private

    def inquiry_params
      params.require(:inquiry).permit(
        :reason_for_interest,
        :where_did_you_hear_about_us,
        :startup_location
      )
    end
  end
end
