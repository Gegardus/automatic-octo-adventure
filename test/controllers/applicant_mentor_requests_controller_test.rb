# frozen_string_literal: true

require 'test_helper'

class ApplicantMentorRequestsControllerTest < ActionDispatch::IntegrationTest
  test '#create' do
    given_signed_in_as :jim

    addressees_count = User.mentor.or(User.admin).count

    assert_emails addressees_count do
      post applicant_mentor_requests_path
    end

    assert_redirected_to modules_path

    assert_success_alert 'Mentor request was successfully created.'
  end

  test '#show' do
    kali = users(:kali)
    given_signed_in_as :bob

    get applicant_mentor_path

    assert_response :success

    assert_text kali.full_name
    assert_text kali.email
    assert_text kali.phone
  end
end
