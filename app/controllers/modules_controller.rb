# frozen_string_literal: true

class ModulesController < ApplicationController
  authorized_when { current_user.present? }

  def index
    @inquiry = current_user.inquiry

    return redirect_to new_suv_application_team_name_path if @inquiry.nil?

    @application_modules = ApplicationModules.new(applicant: current_user)
  end
end
