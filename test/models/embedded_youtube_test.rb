# frozen_string_literal: true

require 'test_helper'

class EmbeddedYoutubeTest < ActiveSupport::TestCase
  test 'embedded youtube' do
    embedded_youtube = EmbeddedYoutube.new(id: 'some-youtube-id')

    assert_not_nil embedded_youtube.attachable_sgid
    assert_equal 'https://i3.ytimg.com/vi/some-youtube-id/maxresdefault.jpg', embedded_youtube.thumbnail_url
    assert_equal 'embedded_youtubes/thumbnail', embedded_youtube.to_trix_content_attachment_partial_path
    assert_equal '[YouTube Video ID some-youtube-id]', embedded_youtube.attachable_plain_text_representation
  end
end
