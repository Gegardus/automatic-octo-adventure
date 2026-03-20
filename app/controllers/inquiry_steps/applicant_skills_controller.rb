# frozen_string_literal: true

module InquirySteps
  class ApplicantSkillsController < ApplicationController
    authorized_when { current_user.applicant? }

    include StepsForInquiry
    before_action -> { setup_inquiry_for_step(:applicant_skill) }

    def index
      @applicant_skills = current_user.applicant_skills
    end

    def show
      @applicant_skill = current_user.applicant_skills.find(params[:id])
    end

    def new
      @applicant_skill = current_user.applicant_skills.new
    end

    def edit
      @applicant_skill = current_user.applicant_skills.find(params[:id])
    end

    def create
      @applicant_skill = current_user.applicant_skills.build(applicant_skill_params)

      @applicant_skill.save

      respond_with @applicant_skill, location: inquiry_steps_applicant_skills_path
    end

    def update
      @applicant_skill = current_user.applicant_skills.find(params[:id])

      @applicant_skill.update(applicant_skill_params)

      respond_with @applicant_skill, location: inquiry_steps_applicant_skills_path
    end

    def destroy
      @applicant_skill = current_user.applicant_skills.find(params[:id])

      @applicant_skill.destroy

      respond_with @applicant_skill, location: inquiry_steps_applicant_skills_path
    end

    private

    def applicant_skill_params
      params.require(:applicant_skill).permit(:description, :proficiency_level, :skill_type, :certification)
    end
  end
end
