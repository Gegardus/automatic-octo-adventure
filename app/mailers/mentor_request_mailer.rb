# frozen_string_literal: true

class MentorRequestMailer < ApplicationMailer
  def new_mentor_request
    @mentor_request = params[:mentor_request]
    @staff_user = params[:staff_user]
    mail(to: @staff_user.email, subject: 'New mentor request')
  end
end
