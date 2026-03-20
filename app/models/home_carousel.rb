# frozen_string_literal: true

# Configuration for home page carousel
class HomeCarousel < ApplicationRecord
  has_one_attached :image_one
  has_one_attached :image_two
  has_one_attached :image_three
end
