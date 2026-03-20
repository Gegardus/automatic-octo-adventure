# frozen_string_literal: true

require 'test_helper'

module Users
  class RegistrationsControllerTest < ActionDispatch::IntegrationTest
    teardown do
      SimpleCaptcha.always_pass = Rails.env.test?
    end

    test '#create' do
      SimpleCaptcha.always_pass = false
      captcha = SimpleCaptcha::SimpleCaptchaData.create!(key: 'captcha_key', value: 'BALQO')

      post user_registration_path, params: {
        user: valid_user_params,
        captcha: captcha.value,
        captcha_key: captcha.key
      }

      assert_response :redirect

      assert_success_alert 'Welcome! You have signed up successfully.'
    end

    test '#create fails with invalid captcha' do
      SimpleCaptcha.always_pass = false

      post user_registration_path, params: {
        user: valid_user_params
      }

      assert_response :unprocessable_entity
      assert_danger_alert 'Captcha code is incorrect. Please try again.'
    end

    test '#update' do
      given_signed_in_as :kali

      put user_registration_path, params: {
        user: valid_user_params.merge(current_password: 'password123')
      }

      assert_response :redirect

      assert_success_alert 'Your account has been updated successfully.'
    end

    test '#update fails' do
      given_signed_in_as :kali

      put user_registration_path, params: {
        user: valid_user_params.merge(current_password: nil)
      }

      assert_response :unprocessable_entity

      assert_danger_alert "Current password can't be blank"
    end

    def valid_user_params
      {
        first_name: 'Vahan',
        last_name: 'Khach',
        phone: '599 111111',
        email: 'vahan@test.com',
        date_of_birth: '30/10/2000',
        password: 'password123',
        password_confirmation: 'password123',
        remember_me: '0'
      }
    end
  end
end
