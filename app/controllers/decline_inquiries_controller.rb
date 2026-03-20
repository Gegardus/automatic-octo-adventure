# frozen_string_literal: true

class DeclineInquiriesController < ApplicationController
  authorized_when { current_user.admin? }

  def edit
    @inquiry = Inquiry.find(params[:id])
  end

  def update
    @inquiry = Inquiry.find(params[:id])

    send_inquiry_declined_emails if @inquiry.update(decline_params.merge(status: :declined))

    respond_with @inquiry, location: suv_application_path(@inquiry.suv_application),
                           notice: 'Inquiry has been declined, all applicants have been emailed.'
  end

  private

  def decline_params
    params.require(:inquiry).permit(:decline_reason)
  end

  def send_inquiry_declined_emails
    @inquiry.applicants.each do |applicant|
      SuvApplicationMailer.with(suv_application: @inquiry.suv_application,
                                applicant: applicant).inquiry_declined.deliver_later
    end
  end
end
