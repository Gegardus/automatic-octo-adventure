# frozen_string_literal: true

module InquirySteps
  class OtherApplicantsController < ApplicationController
    authorized_when { current_user.applicant? }

    include StepsForInquiry
    before_action -> { setup_inquiry_for_step(:applicant_detail) }

    def new
      @user = User.new
    end

    def create
      @user = User.invite!(user_params)

      respond_with @user, location: inquiry_steps_applicant_detail_path, notice: "#{@user.email} has been invited"
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :suv_application_id)
    end
  end
end
