# frozen_string_literal: true

require 'application_responder'

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from AuthorizationError, with: :handle_authorization_error
  after_action :ensure_authorized_when_called!, unless: :devise_controller?

  include SimpleCaptcha::ControllerHelpers

  self.responder = ApplicationResponder
  respond_to :html

  default_form_builder AlignedFormBuilder

  layout :current_layout

  class << self
    attr_accessor :anon_route, :authorized_when_called
  end

  def self.authorized_when(&)
    before_action do
      authorized = instance_eval(&)
      self.class.authorized_when_called = true

      unless authorized
        raise AuthorizationError,
              "#{current_user.email} is not authorized to use the #{class_name_of_controller}"
      end
    end
  end

  def self.skip_before_action(action)
    self.anon_route = true if action == :authenticate_user!
    super
  end

  private

  def current_layout
    return 'anonymous' if current_user.nil?

    'application'
  end

  def handle_authorization_error(_exception)
    render template: 'errors/unauthorized', status: :unauthorized, layout: 'anonymous'
  end

  def ensure_authorized_when_called!
    error = "Please call authorized_when in #{class_name_of_controller}"

    self.class.anon_route || self.class.authorized_when_called || raise(error)
  end

  def class_name_of_controller
    "#{controller_name.titleize.gsub(' ', '')}Controller"
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:accept_invitation,
                                      keys: %i[phone date_of_birth marital_status])
  end

  # :nocov:
  def after_accept_path_for(resource)
    if current_user.inquiry.present?
      inquiry_steps_applicant_detail_path(current_user.inquiry)
    else
      super
    end
  end
  # :nocov:
end
