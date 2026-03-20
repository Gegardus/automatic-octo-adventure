# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative 'coverage_helper'
require_relative 'controller_test_helper'
require_relative 'given_signed_in_test_helper'
require_relative 'validate_assertions'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/mock'

module ActiveSupport
  class TestCase
    include ValidateAssertions
    include ControllerTestHelper
    include GivenSignedInTestHelper
    include ActionMailer::TestHelper

    Capybara.enable_aria_label = true

    parallelize(workers: :number_of_processors)

    fixtures :all

    if ENV['COVERAGE']
      parallelize_setup do |worker|
        SimpleCov.command_name "#{SimpleCov.command_name}-#{worker}"
      end

      parallelize_teardown do
        SimpleCov.result
      end
    end

    include Devise::Test::IntegrationHelpers

    def set_fitpal_to_in_progress
      inquiries(:fitpal).update_columns(
        submission_confirmed: false,
        submission_date: nil,
        submission_full_name: nil,
        status: :in_progress
      )
    end
  end
end
