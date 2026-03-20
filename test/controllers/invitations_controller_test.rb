# frozen_string_literal: true

require 'test_helper'

class InvitationsControllerTest < ActionDispatch::IntegrationTest
  test '#new' do
    given_signed_in_as :dom

    get new_invitation_path

    assert_page_header 'Invite User'

    assert_form url: invitations_path
  end

  test '#create' do
    given_signed_in_as :dom

    assert_difference 'User.count' do
      post invitations_path, params: {
        user: valid_params
      }
    end

    assert_response :redirect
    assert_equal suv_application, User.last.suv_application
  end

  private

  def valid_params
    {
      first_name: 'Vahan',
      last_name: 'Khach',
      email: 'vahan@test.com',
      role: 'applicant',
      suv_application_id: suv_application.id
    }
  end

  def suv_application
    suv_applications(:fitpal_application)
  end
end
