# frozen_string_literal: true

require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test '#show' do
    given_signed_in_as(:bob)

    get root_path

    assert_text 'Welcome Bob Dole'
    assert_page_header 'Aligned SUV'
  end
end
