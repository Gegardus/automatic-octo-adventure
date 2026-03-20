# frozen_string_literal: true

class CurrentUserPasswordsController < ApplicationController
  authorized_when { current_user.present? }

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    return unless @user.update_with_password(password_update_params)

    redirect_to root_path, notice: 'Password updated successfully.'
  end

  private

  def password_update_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
