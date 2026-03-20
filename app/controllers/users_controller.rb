# frozen_string_literal: true

class UsersController < ApplicationController
  authorized_when { current_user.admin? }

  def index
    @q = User.ransack(params[:q])
    @users  = @q.result.includes(:inquiry)
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    @user.update(user_params)

    respond_with @user
  end

  private

  def user_params
    params.require(:user).permit(:account_active)
  end
end
