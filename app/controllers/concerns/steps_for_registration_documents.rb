# frozen_string_literal: true

module StepsForRegistrationDocuments
  extend ActiveSupport::Concern

  included do
    layout 'steps'
  end

  def setup_registration_documents_for_step(step_name)
    return unless current_user.applicant?

    @steps = RegistrationDocuments.new(applicant: current_user).steps_for_applicant
    @current_step = @steps.step_for_step_name(step_name)
    @step_links = %w[register_business online_registration bank_account].map do |step|
      view_context.module_step_path_for(:registration_documents, step)
    end
    @steps.current_step = @current_step

    redirect_if_step_skipped
  end

  def redirect_if_step_skipped
    return unless @current_step.skipped?

    next_step_name = @steps.next_step&.step_name
    return redirect_to view_context.module_step_path_for(:registration_documents, next_step_name) if next_step_name

    redirect_to modules_path
  end
end
