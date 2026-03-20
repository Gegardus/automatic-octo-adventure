# frozen_string_literal: true

require 'test_helper'

class MentorRequestsControllerTest < ActionDispatch::IntegrationTest
  test 'index' do
    mentor_request = mentor_requests(:fitpal_request)

    given_signed_in_as :kali

    get mentor_requests_path

    assert_text mentor_request.suv_application.team_name
  end

  test 'show' do
    mentor_request = mentor_requests(:fitpal_request)

    given_signed_in_as :kali

    get mentor_request_path(mentor_request)

    assert_text 'Kali Bull'
  end

  test '#new' do
    given_signed_in_as :dom

    get new_mentor_request_path

    assert_response :success
    assert_page_header 'New mentor request'
    assert_form url: mentor_requests_path
  end

  test '#create' do
    given_signed_in_as :dom
    suv_application = suv_applications(:off_boundaries_travel_application)

    assert_difference 'MentorRequest.count', 1 do
      post mentor_requests_path, params: {
        mentor_request: {
          suv_application_id: suv_application.id
        }
      }
    end

    assert_success_alert 'Mentor request was successfully created.'
  end

  test '#create fails' do
    given_signed_in_as :dom
    fitpal_application = suv_applications(:fitpal_application)

    assert_no_difference 'MentorRequest.count' do
      post mentor_requests_path, params: {
        mentor_request: {
          suv_application_id: fitpal_application.id
        }
      }
    end

    assert_danger_alert 'Suv application already has a mentor request'
  end

  test 'edit' do
    mentor_request = mentor_requests(:fitpal_request)

    given_signed_in_as :kali

    get edit_mentor_request_path(mentor_request)

    assert_text 'Kali Bull'
  end

  test 'update' do
    alec = users(:alec)
    mentor_request = mentor_requests(:fitpal_request)

    given_signed_in_as :kali

    put mentor_request_path(mentor_request), params: {
      mentor_request: {
        mentor_ids: [alec.id]
      }
    }

    assert_redirected_to mentor_request

    assert_equal [alec], mentor_request.reload.mentors
  end
end
