# frozen_string_literal: true

module InquirySteps
  class ApplicantWorkExperiencesController < ApplicationController
    authorized_when { current_user.applicant? }

    include StepsForInquiry
    before_action -> { setup_inquiry_for_step(:applicant_work_experience) }

    def index
      @applicant_work_experiences = current_user.applicant_work_experiences
    end

    def show
      @applicant_work_experience = current_user.applicant_work_experiences.find(params[:id])
    end

    def new
      @applicant_work_experience = current_user.applicant_work_experiences.new
    end

    def edit
      @applicant_work_experience = current_user.applicant_work_experiences.find(params[:id])
    end

    def create
      @applicant_work_experience = current_user.applicant_work_experiences.build(applicant_work_experience_params)

      @applicant_work_experience.save

      respond_with @applicant_work_experience, location: inquiry_steps_applicant_work_experiences_path
    end

    def update
      @applicant_work_experience = current_user.applicant_work_experiences.find(params[:id])

      @applicant_work_experience.update(applicant_work_experience_params)

      respond_with @applicant_work_experience, location: inquiry_steps_applicant_work_experiences_path
    end

    def destroy
      @applicant_work_experience = current_user.applicant_work_experiences.find(params[:id])

      @applicant_work_experience.destroy

      respond_with @applicant_work_experience, location: inquiry_steps_applicant_work_experiences_path
    end

    private

    def applicant_work_experience_params
      params.require(:applicant_work_experience).permit(:company, :job_title, :responsibilities, :tenure, :location)
    end
  end
end
