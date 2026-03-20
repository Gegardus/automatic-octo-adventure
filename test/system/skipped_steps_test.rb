# frozen_string_literal: true

require 'application_system_test_case'

class SkippedStepsTest < ApplicationSystemTestCase
  test 'skip steps for the team' do
    if js?
      # Given i am an admin
      given_signed_in_as :dom
      visit root_url
      click_link 'Skipped steps'

      # When i create a skip step request for fitpal's applicant_detail_step
      click_link 'New skipped step'
      choose 'Yes'
      select 'Fitpal team', from: 'Team'
      select 'Pre incubation', from: 'Module name'
      fill_in_multi_select 'Applicant detail', from: 'Step to skip'
      click_button 'Save'

      # Then all of fitpal members can skip applicant_detail_step
      assert_text 'Skipped step was successfully created.'
    end
  end

  test 'skip steps for the applicant' do
    if js?
      # Given i am an admin
      given_signed_in_as :dom
      visit root_url
      click_link 'Skipped steps'

      # When i create a skip step request for applicant_detail_step for bob
      click_link 'New skipped step'
      choose 'No'
      select 'Bob Dole', from: 'Applicant'
      select 'Pre incubation', from: 'Module name'
      fill_in_multi_select 'Applicant detail', from: 'Step to skip'
      click_button 'Save'

      # Then only bob can skip applicant_detail_step
      assert_text 'Skipped step was successfully created.'
    end
  end
end
