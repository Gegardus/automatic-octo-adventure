# frozen_string_literal: true

class MentorRequestMailerPreview < ActionMailer::Preview
  def new_mentor_request_mail_preview
    MentorRequestMailer.with(user: users(:jim), mentor: users(:alec)).new_mentor_request
  end
end
