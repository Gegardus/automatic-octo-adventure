# frozen_string_literal: true

require 'test_helper'

class CurrentUserPasswordsControllerTest < ActionDispatch::IntegrationTest
  test '#edit' do
    given_signed_in_as :bob

    get edit_current_user_passwords_path

    assert_page_header 'Edit Password'

    assert_form url: current_user_passwords_path
  end

  test '#update' do
    given_signed_in_as :bob

    patch current_user_passwords_path, params: {
                                        user: valid_user_params.merge(current_password: 'password123')
                                      }

    assert_response :redirect

    assert_success_alert 'Password updated successfully.'
  end

  def valid_user_params
    {
      password: 'password',
      password_confirmation: 'password'
    }
  end
end
