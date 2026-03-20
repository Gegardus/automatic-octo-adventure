# frozen_string_literal: true

require 'application_system_test_case'

class MentorRequestsTest < ApplicationSystemTestCase
  test 'mentor requests' do
    # Given i am an applicant
    bob = given_signed_in_as :ben
    visit root_url

    # When i submit a mentor request
    click_link 'Modules'
    click_button 'Request mentor'

    assert_text 'Mentor request was successfully created.'

    # And the mentor assigns themselves to the request
    given_signed_in_as :kali
    visit root_url
    click_link 'Mentor requests'
    click_link bob.suv_application.team_name
    click_link 'Edit'
    # TODO: figure out why the multi select does not work in js tests
    fill_in_multi_select 'Kali Bull', from: 'Mentors'
    click_button 'Update Mentor request'

    assert_text 'Mentor request was successfully updated.'

    # Then i can see my mentor
    given_signed_in_as :bob
    visit root_url
    click_link 'Modules'
    click_link 'Mentors'

    assert_text 'Kali Bull'
  end

  test 'admin creates mentor request' do
    # Given i am an admin
    given_signed_in_as :lily
    visit root_url

    # When i submit a mentor request
    click_link 'Mentor requests'
    click_link 'New mentor request'

    select 'Travel team', from: 'Teams'
    fill_in_multi_select 'Kali Bull', from: 'Mentors'

    click_button 'Create Mentor request'

    # Then i can see a success message and team name in the mentor requests list
    assert_text 'Mentor request was successfully created.'
    assert_text 'Travel team'
  end
end
