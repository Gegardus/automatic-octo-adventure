# frozen_string_literal: true

class CurrentUsersController < ApplicationController
  authorized_when { current_user.present? }

  def show; end
end
