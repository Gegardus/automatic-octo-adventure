# frozen_string_literal: true

class InvitationsController < ApplicationController
  authorized_when { current_user.admin? }

  def new
    @user = User.new(user_params)
  end

  def create
    @user = User.invite!(user_params)

    redirect_to users_path, notice: "An invitation email has been sent to #{@user.email}"
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:first_name, :last_name, :email, :role, :suv_application_id)
  end
end
