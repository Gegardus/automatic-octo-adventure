# frozen_string_literal: true

require 'test_helper'

class ApplicantProgressControllerTest < ActionDispatch::IntegrationTest
  test 'show' do
    given_signed_in_as :jim

    get application_progress_path

    assert_text '7%'
  end
end
