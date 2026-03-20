# frozen_string_literal: true

module InquirySteps
  class ConfirmationsController < ApplicationController
    authorized_when { current_user.applicant? }
    include StepsForInquiry
    before_action -> { setup_inquiry_for_step(:confirmation) }

    def show; end

    def update
      email_all_admins if @inquiry.update(inquiry_params.merge(status: :submitted))

      respond_with @inquiry, location: inquiry_steps_confirmations_path
    end

    private

    def inquiry_params
      params.require(:inquiry).permit(
        :submission_confirmed,
        :submission_date,
        :submission_full_name
      )
    end

    def email_all_admins
      User.active_admin.each do |admin|
        InquiryMailer.with(inquiry: @inquiry, admin: admin).inquiry_awaiting_approval.deliver_later
      end
    end
  end
end
