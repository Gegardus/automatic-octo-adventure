# frozen_string_literal: true

class MentorRequestsController < ApplicationController
  authorized_when { current_user.mentor? || current_user.admin? }

  def index
    @mentor_requests = MentorRequest.all
  end

  def show
    @mentor_request = MentorRequest.find(params[:id])
  end

  def new
    @mentor_request = MentorRequest.new
    @mentors = User.active_mentor
    @suv_applications = SuvApplication.all
  end

  def edit
    @mentor_request = MentorRequest.find(params[:id])
    @mentors = User.active_mentor
  end

  def create
    @suv_applications = SuvApplication.all
    @mentors = User.active_mentor
    @mentor_request = MentorRequest.new(mentor_request_params)

    @mentor_request.save

    respond_with @mentor_request
  end

  def update
    @mentors = User.active_mentor

    @mentor_request = MentorRequest.find(params[:id])

    @mentor_request.update(mentor_request_params)

    respond_with @mentor_request
  end

  private

  def mentor_request_params
    params.require(:mentor_request).permit(:suv_application_id, mentor_ids: [])
  end
end
