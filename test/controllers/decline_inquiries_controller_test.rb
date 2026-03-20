# frozen_string_literal: true

require 'test_helper'

class DeclineInquiryControllerTest < ActionDispatch::IntegrationTest
  test '#edit' do
    inquiry = inquiries(:fitpal)

    given_signed_in_as :dom

    get edit_decline_inquiry_path(inquiry)

    assert_response :success
  end

  test '#update' do
    inquiry = inquiries(:fitpal)

    given_signed_in_as :dom

    applicants_count = inquiry.applicants.count

    assert_emails applicants_count do
      put decline_inquiry_path(inquiry), params: {
        inquiry: {
          decline_reason: 'the worst idea ever'
        }
      }
    end

    assert_response :redirect

    assert_predicate inquiry.reload, :declined?
  end

  test '#update fails' do
    inquiry = inquiries(:fitpal)

    given_signed_in_as :dom

    assert_emails 0 do
      put decline_inquiry_path(inquiry), params: {
        inquiry: {
          decline_reason: nil
        }
      }
    end

    assert_response :unprocessable_entity

    assert_text "Decline reason can't be blank"
  end
end
