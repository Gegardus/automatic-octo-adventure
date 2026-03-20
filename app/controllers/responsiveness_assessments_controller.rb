# frozen_string_literal: true

class ResponsivenessAssessmentsController < ApplicationController
  authorized_when { current_user.applicant? }

  include StepsForQuickAssessment

  before_action -> { setup_quick_assessment_for_step(:responsiveness_assessment) }

  def edit
    @responsiveness_assessment = responsiveness_assessment
  end

  def update
    @responsiveness_assessment = responsiveness_assessment

    @responsiveness_assessment.assign_attributes(responsiveness_assessment_params)

    current_user.update!(responsiveness_assessment: @responsiveness_assessment) if @responsiveness_assessment.valid?

    respond_with @responsiveness_assessment, location: quick_assessment_path(current_user.id)
  end

  private

  def responsiveness_assessment_params
    params.require(:responsiveness_assessment).permit(*ResponsivenessAssessment::QUESTIONS)
  end

  def responsiveness_assessment
    current_user.responsiveness_assessment || current_user.build_responsiveness_assessment
  end
end
