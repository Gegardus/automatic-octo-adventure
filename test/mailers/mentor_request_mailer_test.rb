# frozen_string_literal: true

require 'test_helper'

class MentorRequestMailerTest < ActionMailer::TestCase
  test 'new mentor request mailer' do
    mentor_request = mentor_requests(:fitpal_request)
    staff_user = users(:alec)
    email = MentorRequestMailer.with(mentor_request: mentor_request, staff_user: staff_user).new_mentor_request

    assert_equal email.to, [staff_user.email]
    assert_equal ['aligned@cosmicdevelopment.xyz'], email.from
    assert_equal 'New mentor request', email.subject
    assert_match 'A new mentor request has been submitted.', email.body.encoded
  end
end
