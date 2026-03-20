# frozen_string_literal: true

class BusinessModelsController < ApplicationController
  authorized_when { current_user.applicant? }

  include StepsForBusinessModel

  before_action :setup_business_model

  def show
    @business_model = current_user.suv_application.build_business_model
    @business_model.assign_attributes(business_model_params)
    render params[:section]
  end

  def update # rubocop:disable Metrics/AbcSize
    @business_model = current_user.suv_application.build_business_model

    return unless @business_model.update(business_model_params.merge(current_step: params[:section]))

    return redirect_to(modules_path, notice: "#{@steps.title} complete!") if @steps.next_step.nil?

    redirect_to business_models_path(section: @steps.next_step.step_name)
  end

  private

  def business_model_params
    params.fetch(:business_model, {}).permit(
      *BusinessModel::BUILDING_BUSINESS_ATTRS, *BusinessModel::BUSINESS_PLAN_ATTRS
    )
  end

  def setup_business_model
    setup_business_models_for_step(params[:section].to_sym)
  end
end
