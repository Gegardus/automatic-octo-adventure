# frozen_string_literal: true

class HelpRequestsController < ApplicationController
  authorized_when { current_user.admin? }

  def index
    @help_requests = HelpRequest.all
  end

  def show
    @help_request = HelpRequest.find(params[:id])
  end

  def edit
    @help_request = HelpRequest.find(params[:id])
    @admins = User.active_admin
  end

  def update
    @help_request = HelpRequest.find(params[:id])

    @help_request.update(help_request_params)

    respond_with @help_request
  end

  private

  def help_request_params
    params.require(:help_request).permit(:admin_id)
  end
end
