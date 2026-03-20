# frozen_string_literal: true

require 'application_system_test_case'

class ImmigrationQuizzesTest < ApplicationSystemTestCase
  test 'help requests' do
    if js?
      # Given i am an applicant
      given_signed_in_as :jim
      visit root_url

      # When i submit a help request
      click_link 'Help requests'
      click_link 'New help request'

      fill_in 'Details', with: 'I need help figuring out my business'
      select 'Immigration', from: 'Module name'
      select 'Legal', from: 'Module section'

      click_button 'Create Help request'

      assert_text 'Help request was successfully created.'

      # Then the admin can see the help request
      given_signed_in_as :dom
      visit root_url
      click_link 'Help requests'

      click_link 'I need help figuring out my business'

      assert_text 'I need help figuring out my business'
    end
  end
end
