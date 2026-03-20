# frozen_string_literal: true

require 'test_helper'

class SuvApplicationMailerTest < ActionMailer::TestCase
  test '#inquiry_approved' do
    inquiry = inquiries(:off_boundaries_travel)
    applicant = users(:jim)
    email = SuvApplicationMailer.with(suv_application: inquiry.suv_application, applicant: applicant).inquiry_approved

    assert_equal email.to, [applicant.email]
    assert_equal ['aligned@cosmicdevelopment.xyz'], email.from
    assert_equal "#{inquiry.team_name} inquiry approved", email.subject
    assert_match "#{inquiry.team_name} inquiry has been approved. You can now proceed to the next module.", email.body.encoded # rubocop:disable Layout/LineLength
  end

  test '#inquiry_declined' do
    inquiry = inquiries(:off_boundaries_travel)
    applicant = users(:jim)
    email = SuvApplicationMailer.with(suv_application: inquiry.suv_application, applicant: applicant).inquiry_declined

    assert_equal email.to, [applicant.email]
    assert_equal ['aligned@cosmicdevelopment.xyz'], email.from
    assert_equal "#{inquiry.team_name} inquiry declined", email.subject
    assert_match "We are extremely sorry and regret to inform you that #{inquiry.team_name} inquiry has been declined.", email.body.encoded # rubocop:disable Layout/LineLength
  end
end
