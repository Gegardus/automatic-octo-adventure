# frozen_string_literal: true

class RefiningYourIdeaModulesController < ApplicationController
  authorized_when { current_user.applicant? }

  include StepsForRefiningYourIdea

  before_action -> { setup_refining_your_idea_modules_for_step(params[:section].to_sym) }
  before_action :create_refining_your_idea_module
  before_action :set_refining_your_idea_module

  def show
    @refining_your_idea_module.assign_attributes(refining_your_idea_module_params)
    render params[:section]
  end

  def update # rubocop:disable Metrics/AbcSize
    if @refining_your_idea_module.update(refining_your_idea_module_params.merge(current_step: params[:section]))

      return redirect_to(modules_path, notice: "#{@steps.title} complete!") if @steps.next_step.nil?

      redirect_to refining_your_idea_modules_path(section: @steps.next_step.step_name)
    else
      render params[:section], status: :unprocessable_entity
    end
  end

  private

  def create_refining_your_idea_module
    return if current_user.refining_your_idea_module.present?

    current_user.update!(refining_your_idea_module: RefiningYourIdeaModule.new)
  end

  def set_refining_your_idea_module
    @refining_your_idea_module = current_user.refining_your_idea_module
  end

  def refining_your_idea_module_params
    params.fetch(:refining_your_idea_module, {}).permit(
      :personal_passion, :target_audience, :product_service_address, :market_gaps, :potential_user_feedback,
      :technical_financial_feasibility, :scalability, :flexibility, :idea_description, :mission_statement,
      :vision_statement, :values, :value_proposition, :stage, :other_stage,
      :short_term_goal_1, :short_term_goal_2, :short_term_goal_3, :short_term_goal_4, :short_term_goal_5,
      :short_term_goal_6, :short_term_goal_7, :short_term_goal_8, :short_term_goal_9, :short_term_goal_10,
      :long_term_goal_1, :long_term_goal_2, :long_term_goal_3, :long_term_goal_4, :long_term_goal_5
    )
  end
end
