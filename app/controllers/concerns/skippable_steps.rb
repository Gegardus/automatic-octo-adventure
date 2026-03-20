# frozen_string_literal: true

module SkippableSteps
  extend ActiveSupport::Concern

  def skipped_for_application?
    !!SkippedStep.find_by(suv_application: applicant.suv_application, step_name: step_name)
  end

  def skipped_for_user?
    !!SkippedStep.find_by(user: applicant, step_name: step_name)
  end

  def skipped?
    skipped_for_application? || skipped_for_user?
  end
end
