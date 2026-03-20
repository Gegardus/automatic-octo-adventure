# frozen_string_literal: true

class ApproveInquiriesController < ApplicationController
  authorized_when { current_user.admin? }

  def update
    @inquiry = Inquiry.find(params[:id])

    send_inquiry_approved_emails if @inquiry.update(status: :approved)

    respond_with @inquiry.suv_application, notice: 'Inquiry has been approved, all applicants have been emailed.'
  end

  private

  def send_inquiry_approved_emails
    @inquiry.applicants.each do |applicant|
      SuvApplicationMailer.with(suv_application: @inquiry.suv_application,
                                applicant: applicant).inquiry_approved.deliver_later
    end
  end
end
