# frozen_string_literal: true

module StepsForImmigration
  extend ActiveSupport::Concern

  included do
    layout 'steps'
  end

  def setup_immigration_for_step(step_name)
    return unless current_user.applicant?

    @steps = Immigration.new(applicant: current_user).steps_for_applicant
    @current_step = @steps.step_for_step_name(step_name)
    sections = %w[basic_info startup legal housing education helpful_tips final_quiz]
    @step_links = sections.map { |step| view_context.module_step_path_for(:immigration_module, step) }
    @steps.current_step = @current_step

    redirect_if_step_skipped
  end

  def redirect_if_step_skipped
    return unless @current_step.skipped?

    next_step_name = @steps.next_step&.step_name
    return redirect_to view_context.module_step_path_for(:immigration_module, next_step_name) if next_step_name

    redirect_to modules_path
  end
end
