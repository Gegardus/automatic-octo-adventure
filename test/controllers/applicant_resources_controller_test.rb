# frozen_string_literal: true

require 'test_helper'

class ApplicantResourcesControllerTest < ActionDispatch::IntegrationTest
  test '#index' do
    given_signed_in_as :jim

    get applicant_resources_path

    assert_page_header 'Resources'
  end
end
