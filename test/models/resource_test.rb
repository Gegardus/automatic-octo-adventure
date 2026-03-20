# frozen_string_literal: true

require 'test_helper'

class ResourceTest < ActiveSupport::TestCase
  test 'required attributes' do
    assert_invalid "can't be blank", name: nil
    assert_invalid "can't be blank", content: nil

    assert_valid name: 'Great stuff'
    assert_valid content: 'Some really great stuff'
  end
end
