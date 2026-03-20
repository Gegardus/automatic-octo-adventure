# frozen_string_literal: true

class SuvApplicationTeamNamesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :redirect_to_sign_up_for_anon_users
  before_action :redirect_to_modules_if_suv_application_exists, only: :new
  authorized_when { current_user.applicant? }

  def new
    @suv_application = current_user.build_suv_application
  end

  def create
    @suv_application = current_user.build_suv_application(inquiry_params)

    if @suv_application.valid? && current_user.save
      redirect_to new_inquiry_steps_applicant_detail_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def redirect_to_sign_up_for_anon_users
    return if current_user.present?

    store_location_for(:user, request.fullpath)

    redirect_to new_user_registration_path
  end

  def redirect_to_modules_if_suv_application_exists
    suv_application = current_user.suv_application

    redirect_to modules_path if suv_application.present?
  end

  def inquiry_params
    params.require(:suv_application).permit(:team_name)
  end
end
