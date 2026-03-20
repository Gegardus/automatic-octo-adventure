# frozen_string_literal: true

class ApplicantMentorRequestsController < ApplicationController
  authorized_when { current_user.applicant? }

  def show
    @mentor_request = current_user.mentor_request
  end

  def create
    mentor_request = MentorRequest.create!(
      suv_application: current_user.suv_application
    )

    email_all_mentors_and_admins(mentor_request)

    respond_with mentor_request, location: modules_path
  end

  private

  def email_all_mentors_and_admins(mentor_request)
    User.active_mentor.or(User.active_admin).find_each do |staff_user|
      MentorRequestMailer.with(mentor_request: mentor_request, staff_user: staff_user).new_mentor_request.deliver_later
    end
  end
end
