# frozen_string_literal: true

class AssertivenessAssessmentsController < ApplicationController
  authorized_when { current_user.applicant? }

  include StepsForQuickAssessment

  before_action -> { setup_quick_assessment_for_step(:assertiveness_assessment) }

  def edit
    @assertiveness_assessment = assertiveness_assessment
  end

  def update
    @assertiveness_assessment = assertiveness_assessment

    @assertiveness_assessment.assign_attributes(assertiveness_assessment_params)

    current_user.update!(assertiveness_assessment: @assertiveness_assessment) if @assertiveness_assessment.valid?

    respond_with @assertiveness_assessment, location: edit_responsiveness_assessments_path
  end

  private

  def assertiveness_assessment_params
    params.require(:assertiveness_assessment).permit(*AssertivenessAssessment::QUESTIONS)
  end

  def assertiveness_assessment
    current_user.assertiveness_assessment || current_user.build_assertiveness_assessment
  end
end
