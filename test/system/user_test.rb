# frozen_string_literal: true

require 'application_system_test_case'

class UserAuthenticationTest < ApplicationSystemTestCase
  test 'update profile' do
    # Given signed in
    given_signed_in_as :kali

    # When i update my profile
    visit root_url
    click_link 'Profile'
    click_link 'Edit'

    fill_in 'First name', with: 'Bob'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Phone', with: '599 222222'
    fill_in 'Email', with: 'nole@test.com'
    fill_in 'Date of birth', with: '30/10/2000'
    fill_in 'Current password', with: 'password123'
    click_button 'Save'

    # Then my profile is updated
    assert_text 'Your account has been updated successfully.'
  end

  test 'users cannot make any requests if they are deactivated whilst already being signed in' do
    # Given i am signed in
    bob = given_signed_in_as :bob
    visit root_path

    # And my account is deactivated
    bob.update!(account_active: false)

    # When i try to visit an authenticated link
    click_link 'Profile'

    # Then i am told my account is no longer active
    assert_text 'Your account is not active.'
  end
end
