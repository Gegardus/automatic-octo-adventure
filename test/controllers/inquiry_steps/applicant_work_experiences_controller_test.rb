# frozen_string_literal: true

require 'test_helper'

class ApplicantWorkExperienceControllerTest < ActionDispatch::IntegrationTest
  test '#index' do
    given_signed_in_as :bob

    get inquiry_steps_applicant_work_experiences_path

    assert_response :success

    assert_page_header 'Applicant work experiences'
  end

  test '#new' do
    given_signed_in_as :bob

    get new_inquiry_steps_applicant_work_experience_path

    assert_response :success

    assert_page_header 'New Applicant work experience'

    assert_form url: inquiry_steps_applicant_work_experiences_path
  end

  test '#create' do
    given_signed_in_as :bob

    assert_difference('ApplicantWorkExperience.count') do
      post inquiry_steps_applicant_work_experiences_path, params: {
        applicant_work_experience: valid_params
      }
    end

    assert_redirected_to inquiry_steps_applicant_work_experiences_path
  end

  test '#show' do
    given_signed_in_as :bob

    applicant_work_experience = applicant_work_experiences(:bobs_experience)

    get inquiry_steps_applicant_work_experience_path(applicant_work_experience)

    assert_response :success
  end

  test '#edit' do
    given_signed_in_as :bob

    applicant_work_experience = applicant_work_experiences(:bobs_experience)

    get edit_inquiry_steps_applicant_work_experience_path(applicant_work_experience)

    assert_response :success

    assert_page_header 'Edit'

    assert_form url: inquiry_steps_applicant_work_experience_path(applicant_work_experience)
  end

  test '#update' do
    given_signed_in_as :bob

    applicant_work_experience = applicant_work_experiences(:bobs_experience)

    put inquiry_steps_applicant_work_experience_path(applicant_work_experience), params: {
      applicant_work_experience: valid_params
    }

    assert_redirected_to inquiry_steps_applicant_work_experiences_path
  end

  test '#destroy' do
    given_signed_in_as :bob

    applicant_work_experience = applicant_work_experiences(:bobs_experience)

    assert_difference('ApplicantWorkExperience.count', -1) do
      delete inquiry_steps_applicant_work_experience_path(applicant_work_experience)
    end
  end

  private

  def valid_params
    {
      company: 'Amazon',
      job_title: 'Manager',
      responsibilities: 'Lead, mentor, and manage a team of associates.',
      tenure: 'Two years',
      location: 'Washington'
    }
  end
end
