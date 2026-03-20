# frozen_string_literal: true

class ImmigrationModulesController < ApplicationController
  authorized_when { current_user.applicant? }

  include StepsForImmigration

  before_action -> { setup_immigration_for_step(params[:section].to_sym) }
  before_action :create_immigration_module

  def show
    render params[:section]
  end

  private

  def create_immigration_module
    return if current_user.immigration_module.present?

    current_user.update!(immigration_module: ImmigrationModule.new)
  end
end
