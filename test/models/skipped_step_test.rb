# frozen_string_literal: true

require 'test_helper'

class SkippedStepTest < ActiveSupport::TestCase
  test 'validations' do
    assert_invalid "can't be blank", step_name: ''
    assert_invalid step_name: 'Some step name'

    assert_invalid "can't be blank", module_name: ''
    assert_invalid module_name: 'Some module name'
  end
end
