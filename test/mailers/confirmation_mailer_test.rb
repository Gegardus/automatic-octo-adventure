# frozen_string_literal: true

require 'test_helper'

class InquiryMailerTest < ActionMailer::TestCase
  test '#inquiry_awaiting_approval' do
    inquiry = inquiries(:off_boundaries_travel)
    admin = users(:dom)
    email = InquiryMailer.with(inquiry: inquiry, admin: admin).inquiry_awaiting_approval

    assert_equal email.to, [admin.email]
    assert_equal ['aligned@cosmicdevelopment.xyz'], email.from
    assert_equal "#{inquiry.team_name} inquiry awaiting approval", email.subject
    assert_match "#{inquiry.team_name} inquiry has been submitted and is awaiting approval.", email.body.encoded
  end
end
