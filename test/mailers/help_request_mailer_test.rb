# frozen_string_literal: true

require 'test_helper'

class HelpRequestMailerTest < ActionMailer::TestCase
  test 'new help request mailer' do
    help_request = help_requests(:consult_request)
    admin = users(:dom)
    email = HelpRequestMailer.with(help_request: help_request, admin: admin).new_help_request

    assert_equal email.to, [admin.email]
    assert_equal ['aligned@cosmicdevelopment.xyz'], email.from
    assert_equal 'New help request', email.subject
    assert_match 'A new help request has been submitted.', email.body.encoded
  end
end
