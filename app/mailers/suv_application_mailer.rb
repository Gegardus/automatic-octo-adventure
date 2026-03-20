# frozen_string_literal: true

class SuvApplicationMailer < ApplicationMailer
  def inquiry_approved
    @suv_application = params[:suv_application]
    @applicant = params[:applicant]
    mail(to: @applicant.email, subject: "#{@suv_application.team_name} inquiry approved")
  end

  def inquiry_declined
    @suv_application = params[:suv_application]
    @applicant = params[:applicant]
    mail(to: @applicant.email, subject: "#{@suv_application.team_name} inquiry declined")
  end
end
