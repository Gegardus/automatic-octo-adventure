# frozen_string_literal: true

require 'test_helper'

class EmbeddedVideoTest < ActiveSupport::TestCase
  test 'find returns a new class ' do
    assert EmbeddedVideo.find('some-youtube-id')
  end
end
