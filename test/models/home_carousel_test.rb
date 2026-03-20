# frozen_string_literal: true

require 'test_helper'

class HomeCarouselTest < ActiveSupport::TestCase
  test 'has some attached images' do
    carousel = assert_difference 'ActiveStorage::Attachment.count', 3 do
      HomeCarousel.create!(
        image_one: Rack::Test::UploadedFile.new('test/fixtures/files/placeholder.jpeg', 'image/jpeg'),
        image_two: Rack::Test::UploadedFile.new('test/fixtures/files/placeholder.jpeg', 'image/jpeg'),
        image_three: Rack::Test::UploadedFile.new('test/fixtures/files/placeholder.jpeg', 'image/jpeg')
      )
    end

    assert_predicate carousel.image_one, :attached?
    assert_predicate carousel.image_two, :attached?
    assert_predicate carousel.image_three, :attached?
  end
end
