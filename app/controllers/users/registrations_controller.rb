# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: :create
    before_action :configure_account_update_params, only: :update # rubocop:disable Rails/LexicallyScopedActionFilter

    def create
      if simple_captcha_valid?
        super
      else
        build_resource(sign_up_params)
        clean_up_passwords(resource)
        flash[:alert] = 'Captcha code is incorrect. Please try again.'
        render :new, status: :unprocessable_entity
      end
    end

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: permitted_keys)
    end

    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: permitted_keys)
    end

    private

    def permitted_keys
      %i[remember_me first_name last_name phone date_of_birth]
    end
  end
end
