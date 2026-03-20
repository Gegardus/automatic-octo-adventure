# frozen_string_literal: true

class ApplicationProgressController < ApplicationController
  authorized_when { current_user.applicant? }

  def show
    @suv_application = current_user.suv_application
    @inquiry = @suv_application.inquiry

    @application_modules = ApplicationModules.new(applicant: current_user)
  end
end
