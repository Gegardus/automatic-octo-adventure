# frozen_string_literal: true

module GivenSignedInTestHelper
  def given_signed_in_as(name)
    user = name.is_a?(User) ? name : users(name)
    sign_in(user)
    user
  end
end
