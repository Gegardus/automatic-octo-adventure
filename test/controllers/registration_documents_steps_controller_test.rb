# frozen_string_literal: true

require 'test_helper'

class RegistrationDocStepsControllerTest < ActionDispatch::IntegrationTest
  test '#show' do
    given_signed_in_as :bob

    get registration_documents_steps_path(section: 'online_registration')

    assert_response :success

    assert_page_header 'Online registration'

    assert_form url: registration_document_step_path(section: 'online_registration')
  end

  test '#show redirects to modules when next step is nil and all steps are skipped or completed' do
    given_signed_in_as :jim

    SkippedStep.create!(
      suv_application: users(:jim).suv_application,
      step_name: :bank_account,
      module_name: 'registration_documents'
    )

    get registration_documents_steps_path(section: 'bank_account')

    assert_redirected_to modules_path
  end

  test '#update' do
    given_signed_in_as :jim

    patch registration_document_step_path(section: 'online_registration'), params: {
      suv_application: suv_application_params
    }

    assert_redirected_to registration_document_step_path(section: 'bank_account')
  end

  private

  def suv_application_params
    {
      online_registration_document: fixture_file_upload('test/fixtures/files/placeholder.jpeg', 'image/jpeg'),
      bank_account_document: fixture_file_upload('test/fixtures/files/placeholder.jpeg', 'image/jpeg')
    }
  end
end
