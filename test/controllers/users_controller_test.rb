# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test '#index' do
    given_signed_in_as(:dom)

    get users_path

    User.all.map do |user|
      assert_text user.email
    end
  end

  test '#show' do
    given_signed_in_as(:dom)

    bob = users(:bob)

    get users_path(bob)

    assert_text bob.first_name
  end

  test '#update' do
    given_signed_in_as(:dom)

    bob = users(:bob)

    put user_path(bob), params: {
      user: valid_params
    }

    assert_redirected_to user_path

    assert_success_alert 'User was successfully updated.'
  end

  private

  def valid_params
    {
      account_active: true
    }
  end
end
