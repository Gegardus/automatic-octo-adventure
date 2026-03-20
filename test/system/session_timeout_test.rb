# frozen_string_literal: true

require 'application_system_test_case'

class SessionTimeoutTest < ApplicationSystemTestCase
  test 'session expires after timeout period' do
    # Given i am signed
    given_signed_in_as :bob

    # When i visit the platform one minute before the timeout period
    travel_to(User.timeout_in.ago - 1.minute)
    visit current_user_path

    # Then i am still signed in
    assert_text 'Profile'

    # When i visit the platform after the timeout period
    travel_to(User.timeout_in.from_now)
    visit current_user_path

    # Then i am no longer signed in
    assert_text 'Sign in to your account'
    assert_text 'Your session expired. Please sign in again to continue.'
  end
end
