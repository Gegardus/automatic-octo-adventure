# frozen_string_literal: true

require 'test_helper'

class CurrentUsersControllerTest < ActionDispatch::IntegrationTest
  test '#show' do
    bob = given_signed_in_as :bob

    get current_user_path

    assert_text bob.first_name
    assert_text bob.last_name
    assert_text bob.phone
    assert_text bob.date_of_birth
  end
end
