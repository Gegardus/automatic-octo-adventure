# frozen_string_literal: true

# base class for embedding videos in rich text
class EmbeddedVideo
  include ActiveModel::Model
  include ActiveModel::Attributes
  include GlobalID::Identification
  include ActionText::Attachable

  attribute :id

  def self.find(id)
    new(id: id)
  end

  # NOTE: without this method if a rich text with only youtube is saved
  # calling .present? returns false and the presence validation is hit
  def attachable_plain_text_representation(*)
    "[YouTube Video ID #{id}]"
  end
end
