# frozen_string_literal: true

class SkippedStepsController < ApplicationController
  authorized_when { current_user.admin? }

  def index
    @skipped_steps = SkippedStep.all
  end

  def new
    @multiple_skipped_steps = MultipleSkippedSteps.new(skipped_step_params)
  end

  def create
    @multiple_skipped_steps = MultipleSkippedSteps.new(skipped_step_params)

    @multiple_skipped_steps.save

    respond_with @multiple_skipped_steps, location: skipped_steps_path, notice: 'Skipped step was successfully created.'
  end

  def destroy
    @skipped_step = SkippedStep.find(params[:id])

    @skipped_step.destroy

    respond_with @skipped_step, location: skipped_steps_path
  end

  private

  def skipped_step_params
    params.fetch(:multiple_skipped_steps, {}).permit(
      :suv_application_id, :user_id, :skip_for_team, :module_name, steps_to_skip: []
    )
  end
end
