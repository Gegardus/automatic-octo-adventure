# frozen_string_literal: true

require 'test_helper'

class HomeCarouselsControllerTest < ActionDispatch::IntegrationTest
  test '#edit' do
    given_signed_in_as :dom
    get edit_home_carousel_path

    assert_page_header 'Carousel'

    assert_form url: home_carousel_path
  end

  test '#update' do
    given_signed_in_as :dom

    put home_carousel_path, params: {
      home_carousel: {
        image_one: fixture_file_upload('test/fixtures/files/placeholder.jpeg', 'image/jpeg'),
        image_two: fixture_file_upload('test/fixtures/files/placeholder.jpeg', 'image/jpeg'),
        image_three: fixture_file_upload('test/fixtures/files/placeholder.jpeg', 'image/jpeg')
      }
    }

    assert_response :redirect

    assert_success_alert 'Home carousel was successfully updated.'
  end

  test '#destroy deletes an image from the home carousel' do
    given_signed_in_as :dom

    assert_difference 'ActiveStorage::Attachment.count', -1 do
      delete home_carousel_path(image: :image_one)
    end

    assert_response :redirect

    assert_success_alert 'Image one has been deleted.'
  end
end
