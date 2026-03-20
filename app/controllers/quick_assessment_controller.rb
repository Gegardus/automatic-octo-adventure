# frozen_string_literal: true

class QuickAssessmentController < ApplicationController
  authorized_when { current_user.applicant? }

  include StepsForQuickAssessment

  def show
    setup_quick_assessment_for_step(:results)

    @quick_assessment = QuickAssessment.new(applicant: current_user)
  end

  def new
    setup_quick_assessment_for_step(:introduction)
    current_user.build_assertiveness_assessment
  end
end
