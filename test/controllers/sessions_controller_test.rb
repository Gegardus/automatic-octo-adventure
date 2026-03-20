# frozen_string_literal: true

require 'test_helper'

module Users
  class SessionsControllerTest < ActionDispatch::IntegrationTest
    test '#create' do
      post user_session_path, params: {
        user: {
          email: 'john@test.com',
          password: 'password123'
        }
      }

      assert_response :redirect

      assert_danger_alert 'Your account is not active.'
    end
  end
end
