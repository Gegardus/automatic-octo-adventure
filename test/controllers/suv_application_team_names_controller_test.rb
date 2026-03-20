# frozen_string_literal: true

require 'test_helper'

class SuvApplicationTeamNamesControllerTest < ActionDispatch::IntegrationTest
  test 'redirects to sign up if no user is present' do
    get new_suv_application_team_name_path

    assert_redirected_to new_user_registration_path

    follow_redirect!

    assert_page_header 'Sign up to our platform'
  end

  test 'redirects to modules if one is already present' do
    given_signed_in_as :bob

    get new_suv_application_team_name_path

    assert_redirected_to modules_path
  end

  test 'only applicants can access this controller' do
    given_signed_in_as(:dom)

    get new_suv_application_team_name_path

    assert_response :unauthorized
  end

  test '#new' do
    given_signed_in_as :bill

    get new_suv_application_team_name_path

    assert_text 'We will need to collect some info before submitting the inquiry'

    assert_form url: suv_application_team_names_path
  end

  test '#create' do
    given_signed_in_as :bill

    assert_difference 'SuvApplication.count' do
      post suv_application_team_names_path, params: {
        suv_application: {
          team_name: 'Vanguard'
        }
      }
    end
  end

  test '#create fails' do
    given_signed_in_as :bill

    assert_no_difference 'SuvApplication.count' do
      post suv_application_team_names_path, params: {
        suv_application: {
          team_name: ''
        }
      }
    end

    assert_danger_alert "Team name can't be blank"
  end
end
