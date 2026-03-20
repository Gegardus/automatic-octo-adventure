# frozen_string_literal: true

require 'test_helper'

class ConfirmationsControllerTest < ActionDispatch::IntegrationTest
  test '#show' do
    given_signed_in_as :bob

    get inquiry_steps_confirmations_path

    assert_text 'Step successfully submitted!'
  end

  test '#show redirects to modules when next step is nil and all steps are skipped or completed' do
    given_signed_in_as :jim
    SkippedStep.create!(
      suv_application: users(:jim).suv_application,
      step_name: :confirmation,
      module_name: 'pre_incubation'
    )

    get inquiry_steps_confirmations_path

    assert_redirected_to modules_path
  end

  test '#edit' do
    given_signed_in_as :bob

    set_fitpal_to_in_progress

    get edit_inquiry_steps_confirmations_path

    assert_page_header 'Confirmation'

    assert_form url: inquiry_steps_confirmations_path
  end

  test '#update' do
    given_signed_in_as :bob

    set_fitpal_to_in_progress

    admins_count = User.admin.count

    assert_emails admins_count do
      patch inquiry_steps_confirmations_path, params: {
        inquiry: {
          submission_confirmed: true,
          submission_date: '2023-01-08',
          submission_full_name: 'Bob Dole'
        }
      }
    end

    assert_redirected_to inquiry_steps_confirmations_path

    assert_success_alert 'Inquiry was successfully updated.'
  end

  test '#update fails' do
    given_signed_in_as :bob

    set_fitpal_to_in_progress

    patch inquiry_steps_confirmations_path, params: {
      inquiry: {
        submission_date: '2023-01-08',
        submission_full_name: 'Bob Dole'
      }
    }

    assert_danger_alert "Submission confirmed can't be blank"
  end

  test '#update when its not ready to submit' do
    fitpal = inquiries(:fitpal)

    set_fitpal_to_in_progress

    users(:charlie).update!(suv_application: fitpal.suv_application)

    given_signed_in_as :bob

    assert_predicate fitpal.reload, :in_progress?

    patch inquiry_steps_confirmations_path, params: {
      inquiry: {
        submission_confirmed: true,
        submission_date: '2023-01-08',
        submission_full_name: 'Bob Dole'
      }
    }

    assert_response :unprocessable_entity

    assert_danger_alert 'All applicants must complete applicant specific steps before submitting'

    assert_predicate fitpal.reload, :in_progress?
  end
end
