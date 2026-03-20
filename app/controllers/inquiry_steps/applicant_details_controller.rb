# frozen_string_literal: true

module InquirySteps
  class ApplicantDetailsController < ApplicationController
    authorized_when { current_user.applicant? }

    include StepsForInquiry
    before_action -> { setup_inquiry_for_step(:applicant_detail) }

    def show
      redirect_to new_inquiry_steps_applicant_detail_path if current_user.applicant_detail.nil?
    end

    def new
      if current_user.applicant_detail
        redirect_to edit_inquiry_steps_applicant_detail_path
      else
        @applicant_detail = current_user.build_applicant_detail
      end
    end

    def edit
      @applicant_detail = current_user.applicant_detail
    end

    def create
      @applicant_detail = current_user.build_applicant_detail(applicant_detail_params)

      @applicant_detail.save

      respond_with @applicant_detail, location: inquiry_steps_applicant_detail_path
    end

    def update
      @applicant_detail = current_user.applicant_detail

      @applicant_detail.update(applicant_detail_params)

      respond_with @applicant_detail, location: inquiry_steps_applicant_detail_path
    end

    private

    def applicant_detail_params
      params.require(:applicant_detail).permit(
        :pronouns, :country_of_origin, :country_of_application,
        :native_language, :linkedin_url, :tell_us_about_yourself, :current_address, :marital_status,
        :language_test_result_file
      )
    end
  end
end
