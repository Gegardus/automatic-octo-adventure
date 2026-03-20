# frozen_string_literal: true

module StepsForRefiningYourIdea
  extend ActiveSupport::Concern

  included do
    layout 'steps'
  end

  def setup_refining_your_idea_modules_for_step(step_name)
    return unless current_user.applicant?

    @steps = RefiningYourIdea.new(applicant: current_user).steps_for_applicant
    @current_step = @steps.step_for_step_name(step_name)
    @step_links = %w[your_idea mission vision values value_proposition goals].map do |step|
      view_context.module_step_path_for(:refining_your_idea, step)
    end
    @steps.current_step = @current_step

    redirect_if_step_skipped
  end

  def redirect_if_step_skipped
    return unless @current_step.skipped?

    next_step_name = @steps.next_step&.step_name
    return redirect_to view_context.module_step_path_for(:refining_your_idea, next_step_name) if next_step_name

    redirect_to modules_path
  end
end
