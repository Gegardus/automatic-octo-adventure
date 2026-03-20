# frozen_string_literal: true

class SuvApplicationsController < ApplicationController
  authorized_when { current_user.admin? || current_user.mentor? }

  def index
    @suv_applications = SuvApplication.all
  end

  def show
    @suv_application = SuvApplication.find(params[:id])
  end
end
