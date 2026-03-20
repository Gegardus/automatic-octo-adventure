# frozen_string_literal: true

class InquiryMailer < ApplicationMailer
  def inquiry_awaiting_approval
    @inquiry = params[:inquiry]
    @admin = params[:admin]
    mail(to: @admin.email, subject: "#{@inquiry.team_name} inquiry awaiting approval")
  end
end
