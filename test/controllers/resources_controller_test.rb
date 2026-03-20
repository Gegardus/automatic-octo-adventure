# frozen_string_literal: true

require 'test_helper'

class ResourcesControllerTest < ActionDispatch::IntegrationTest
  test '#index' do
    given_signed_in_as :dom

    get resources_path

    assert_page_header 'Resources'
  end

  test '#new' do
    given_signed_in_as :dom

    get new_resource_path

    assert_page_header 'New Resource'

    assert_form url: resources_path
  end

  test '#show' do
    given_signed_in_as :dom

    resource = resources(:government_guidelines)

    get resource_path(resource)

    assert_text 'Canadian Government Guidelines'
  end

  test '#edit' do
    given_signed_in_as :dom

    resource = resources(:government_guidelines)

    get edit_resource_path(resource)

    assert_response :success

    assert_page_header 'Edit'

    assert_form url: resource_path(resource)
  end

  test '#create' do
    given_signed_in_as :dom

    assert_difference 'Resource.count' do
      post resources_path, params: {
        resource: valid_params
      }
    end

    assert_response :redirect
  end

  test '#update' do
    given_signed_in_as :dom

    resource = resources(:government_guidelines)

    put resource_path(resource), params: {
      resource: valid_params
    }

    assert_response :redirect
  end

  test '#destroy' do
    given_signed_in_as :dom

    resource = resources(:government_guidelines)

    assert_difference 'Resource.count', -1 do
      delete resource_path(resource)
    end
  end

  private

  def valid_params
    {
      name: 'Very new guidlines',
      content: 'These guidlines are super new'
    }
  end
end
