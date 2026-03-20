# frozen_string_literal: true

module InquirySteps
  class ApplicantEducationRecordsController < ApplicationController
    authorized_when { current_user.applicant? }
    include StepsForInquiry
    before_action -> { setup_inquiry_for_step(:applicant_education_record) }

    def index
      @applicant_education_records = current_user.applicant_education_records
    end

    def show
      @applicant_education_record =  current_user.applicant_education_records.find(params[:id])
    end

    def new
      @applicant_education_record = current_user.applicant_education_records.new
    end

    def edit
      @applicant_education_record = current_user.applicant_education_records.find(params[:id])
    end

    def create
      @applicant_education_record = current_user.applicant_education_records.build(applicant_education_record_params)

      @applicant_education_record.save

      respond_with @applicant_education_record, location: inquiry_steps_applicant_education_records_path
    end

    def update
      @applicant_education_record = current_user.applicant_education_records.find(params[:id])

      @applicant_education_record.update(applicant_education_record_params)

      respond_with @applicant_education_record,
                   location: inquiry_steps_applicant_education_records_path
    end

    def destroy
      @applicant_education_record = current_user.applicant_education_records.find(params[:id])

      @applicant_education_record.destroy

      respond_with @applicant_education_record, location: inquiry_steps_applicant_education_records_path
    end

    private

    def applicant_education_record_params
      params.require(:applicant_education_record).permit(:degree_type, :institution_name, :start_date, :end_date,
                                                         :concentration, :graduated)
    end
  end
end
