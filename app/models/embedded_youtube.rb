# frozen_string_literal: true

# allows embedding of youtube links for rich text
class EmbeddedYoutube < EmbeddedVideo
  def thumbnail_url
    "https://i3.ytimg.com/vi/#{id}/maxresdefault.jpg"
  end

  def to_trix_content_attachment_partial_path
    'embedded_youtubes/thumbnail'
  end
end
