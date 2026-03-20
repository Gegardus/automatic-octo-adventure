# frozen_string_literal: true

class ApplicantHelpRequestsController < ApplicationController
  authorized_when { current_user.applicant? }

  def index
    @help_requests = current_user.help_requests
  end

  def show
    @help_request = current_user.help_requests.find(params[:id])
  end

  def new
    @help_request = HelpRequest.new(help_request_params)
    @application_modules = ApplicationModules.new(applicant: current_user)
  end

  def create
    @help_request = HelpRequest.new(help_request_params.merge(suv_application: current_user.suv_application))
    @application_modules = ApplicationModules.new(applicant: current_user)

    email_all_admins if @help_request.save

    respond_with @help_request, location: applicant_help_requests_path
  end

  private

  def help_request_params
    params.fetch(:help_request, {}).permit(:details, :module_name, :module_section)
  end

  def email_all_admins
    User.active_admin.each do |admin|
      HelpRequestMailer.with(help_request: @help_request, admin: admin).new_help_request.deliver_later
    end
  end
end
