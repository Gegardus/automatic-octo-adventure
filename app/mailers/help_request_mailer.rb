# frozen_string_literal: true

class HelpRequestMailer < ApplicationMailer
  def new_help_request
    @help_request = params[:help_request]
    @admin = params[:admin]
    mail(to: @admin.email, subject: 'New help request')
  end
end
