# frozen_string_literal: true

require 'system_test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driver = ENV['JS'] || ENV['GUI'] ? :selenium : :rack_test

  driven_by driver, using: ENV['GUI'] ? :chrome : :headless_chrome, screen_size: [1_400, 1_400] do |option|
    option.add_argument('no-sandbox')
  end
end
