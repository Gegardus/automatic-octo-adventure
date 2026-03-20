# frozen_string_literal: true

require 'test_helper'

class ImmigrationModulesControllerTest < ActionDispatch::IntegrationTest
  test '#show' do
    given_signed_in_as(:bob)

    get immigration_modules_path(section: 'helpful_tips')

    assert_response :success
  end

  test '#show creates module for user if not present' do
    jim = users(:jim)
    given_signed_in_as(:jim)

    assert_nil jim.immigration_module

    get immigration_modules_path(section: 'helpful_tips')

    assert_predicate jim.immigration_module, :present?
  end

  test '#show redirects to modules when next step is nil and all steps are skipped or completed' do
    given_signed_in_as :jim

    SkippedStep.create!(
      suv_application: users(:jim).suv_application,
      step_name: :final_quiz,
      module_name: 'immigration_module'
    )

    get immigration_modules_path(section: 'final_quiz')

    assert_redirected_to modules_path
  end
end
