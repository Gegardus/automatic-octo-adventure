# frozen_string_literal: true

require 'application_system_test_case'

class AdminTest < ApplicationSystemTestCase
  test 'configuring the homepages carousel' do
    # Given i am an admin of the platform
    given_signed_in_as :dom
    visit root_url

    # When i configure the homepage carousel
    click_link 'Carousel'

    attach_file 'Image one', 'test/fixtures/files/placeholder.jpeg'
    attach_file 'Image two', 'test/fixtures/files/placeholder.jpeg'
    attach_file 'Image three', 'test/fixtures/files/placeholder.jpeg'

    click_button 'Update Home carousel'

    # Then my home carousel is configured
    assert_text 'Home carousel was successfully updated.'
  end

  test 'adding resources' do
    # Given i am an admin of the platform
    given_signed_in_as :dom
    visit root_url

    # When i create a resource
    click_link 'Resources'
    click_link 'New Resource'
    fill_in 'Name', with: 'Guide for SUV program'

    fill_in_trix_editor 'Content', with: 'Check out my cool rich content'
    select 'Pre incubation', from: 'Module'
    click_button 'Create Resource'

    # Then my resource is created
    assert_text 'Resource was successfully created.'

    assert_text 'Guide for SUV program'
    assert_text 'Check out my cool rich content'
  end

  test 'editing a resource' do
    resource = resources(:government_guidelines)
    new_name = 'Old guidelines'

    # Given i am an admin of the platform
    given_signed_in_as :dom
    visit resources_path

    # When i edit a resource
    click_link "View #{resource.name}"
    click_link 'Edit'

    fill_in 'Name', with: new_name

    # Then my resource is updated
    click_button 'Update Resource'

    assert_text 'Resource was successfully updated.'

    assert_text new_name
    assert_text resource.content.to_plain_text
  end

  test 'admin deactivates a user' do
    # Given i am an admin
    given_signed_in_as :dom
    visit root_path

    # When i deactivate an applicant
    user = users(:charlie)

    click_link 'Users'
    click_link "View #{user.id}"
    click_button 'Deactivate'

    # Then the applicant is updated
    assert_text 'User was successfully updated.'
  end

  test 'admin invites an applicant' do
    # Given i am an admin
    given_signed_in_as :dom
    visit root_path

    # When i invite Jole as an applicant
    invited_user = invite_user(role: 'Applicant')

    # And Jole accepts the invite
    open_email(invited_user.email)
    current_email.click_link 'Accept invitation'
    fill_in 'Phone', with: '0123456789'
    fill_in 'Date of birth', with: 18.years.ago
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'
    click_button 'Accept Invitation'

    # Then the invitation is accepted
    assert_text 'Invitation accepted.'
    assert_predicate invited_user.reload, :applicant?
  end

  test 'admin invites another admin' do
    # Given i am an admin
    given_signed_in_as :dom
    visit root_path

    # When i invite Jole as an admin
    invited_user = invite_user(role: 'Admin')

    # And Jole accepts the invite
    open_email(invited_user.email)
    current_email.click_link 'Accept invitation'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'
    click_button 'Accept Invitation'

    # Then the invitation is accepted
    assert_text 'Invitation accepted.'
    assert_predicate invited_user.reload, :admin?
  end

  test 'admin searches users' do
    # Given i am an admin
    given_signed_in_as :dom
    visit root_path

    # When i am searching a user
    click_link 'Users'

    assert_text 'John James'
    assert_text 'Bob Dole'
    fill_in 'First name', with: 'Bob'
    fill_in 'Last name', with: 'Dole'
    fill_in 'Email', with: 'bob@test.com'
    fill_in 'Team name', with: 'Fitpal team'

    # Then the page shows the user i am searched for
    click_button 'Search'

    assert_text 'Bob Dole'
    assert_no_text 'John James'
  end

  test 'admin declines an inquiry' do
    fitpal_application = suv_applications(:fitpal_application)
    # Given i am an admin
    given_signed_in_as :dom
    visit suv_application_path(fitpal_application)

    # When i decline an inquiry
    click_link 'Decline'
    fill_in 'Decline reason', with: 'Your idea sucks'
    click_button 'Decline'

    assert_text 'Inquiry has been declined, all applicants have been emailed.'

    # Then the applicants see the decline reason
    given_signed_in_as :bob
    visit modules_path

    assert_text 'Declined'

    click_link 'View decline reason'

    assert_text 'Your idea sucks'

    # When the applicant resubmits the inquiry
    click_link 'Confirmation'
    confirm_submission
    click_button 'Submit Inquiry'

    assert_text 'Thank you for your submission'
    # Then as an admin i can approve it again
    given_signed_in_as :dom
    visit suv_application_path(fitpal_application)

    click_button 'Approve'

    assert_text 'Inquiry has been approved, all applicants have been emailed.'
  end

  private

  def invite_user(role:) # rubocop:disable Metrics/MethodLength
    click_link 'Users'
    click_link 'Invite user'

    assert_page_header 'Invite User'
    fill_in 'First name', with: 'Jole'
    fill_in 'Last name', with: 'Barker'
    fill_in 'Email', with: 'jole@test.com'
    select role, from: 'Role'
    select 'Fitpal team', from: 'Team' if role == 'Applicant'

    assert_emails 1 do
      assert_difference 'User.count' do
        click_button 'Send an invitation'

        assert_text 'An invitation email has been sent to jole@test.com'
        assert_selector 'h1', text: 'Users'
        assert_text 'jole@test.com'
      end
    end
    User.last
  end
end
