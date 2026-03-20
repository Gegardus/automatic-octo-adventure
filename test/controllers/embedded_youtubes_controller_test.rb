# frozen_string_literal: true

require 'test_helper'

class EmbeddedYoutubesControllerTest < ActionDispatch::IntegrationTest
  test 'show returns an sgid and the youtube partial as the content' do
    given_signed_in_as :dom

    get embedded_youtube_url('some-youtube-id')

    json_response = response.parsed_body

    assert_not_nil json_response['sgid']
    assert_not_nil json_response['content']
  end
end
