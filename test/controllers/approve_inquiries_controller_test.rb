# frozen_string_literal: true

require 'test_helper'

class ApproveInquiryControllerTest < ActionDispatch::IntegrationTest
  test '#update with status approved' do
    inquiry = inquiries(:fitpal)

    given_signed_in_as :dom

    applicants_count = inquiry.applicants.count

    assert_emails applicants_count do
      put approve_inquiry_path(inquiry)
    end

    assert_response :redirect

    assert_predicate inquiry.reload, :approved?
  end
end
