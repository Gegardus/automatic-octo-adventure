# frozen_string_literal: true

class RegistrationDocumentsStepsController < ApplicationController
  authorized_when { current_user.applicant? }

  include StepsForRegistrationDocuments

  before_action :setup_registration_document

  def show
    @suv_application = current_user.suv_application

    render params[:section]
  end

  def update
    @suv_application = current_user.suv_application

    return unless @suv_application.update(registration_document_params)

    return redirect_to(modules_path, notice: "#{@steps.title} complete!") if @steps.next_step.nil?

    redirect_to registration_document_step_path(section: @steps.next_step.step_name)
  end

  private

  def registration_document_params
    params.fetch(:suv_application, {}).permit(:online_registration_document, :bank_account_document)
  end

  def setup_registration_document
    setup_registration_documents_for_step(params[:section].to_sym)
  end
end
