# frozen_string_literal: true

require 'test_helper'

class ApplicantSkillControllerTest < ActionDispatch::IntegrationTest
  test '#index' do
    given_signed_in_as :bob

    get inquiry_steps_applicant_skills_path

    assert_response :success

    assert_page_header 'Applicant skills'
  end

  test '#new' do
    given_signed_in_as :bob

    get new_inquiry_steps_applicant_skill_path

    assert_response :success

    assert_page_header 'New Applicant skill'

    assert_form url: inquiry_steps_applicant_skills_path
  end

  test '#create' do
    given_signed_in_as :bob

    assert_difference('ApplicantSkill.count') do
      post inquiry_steps_applicant_skills_path, params: {
        applicant_skill: {
          description: 'I can talk to sheep',
          proficiency_level: 'expert',
          skill_type: 'Soft skill',
          certification: 'None'
        }
      }
    end

    assert_redirected_to inquiry_steps_applicant_skills_path
  end

  test '#show' do
    given_signed_in_as :bob

    applicant_skill = applicant_skills(:bob_driving)

    get inquiry_steps_applicant_skill_path(applicant_skill)

    assert_response :success
  end

  test '#edit' do
    given_signed_in_as :bob

    applicant_skill = applicant_skills(:bob_driving)

    get edit_inquiry_steps_applicant_skill_path(applicant_skill)

    assert_response :success

    assert_text 'Edit'

    assert_form url: inquiry_steps_applicant_skill_path(applicant_skill)
  end

  test '#update' do
    given_signed_in_as :bob
    applicant_skill = applicant_skills(:bob_driving)

    put inquiry_steps_applicant_skill_path(applicant_skill), params: {
      applicant_skill: {
        description: applicant_skill.description,
        proficiency_level: 'expert',
        skill_type: 'Soft skill',
        certification: applicant_skill.certification
      }
    }

    assert_redirected_to inquiry_steps_applicant_skills_path
  end

  test '#destroy' do
    given_signed_in_as :bob

    applicant_skill = applicant_skills(:bob_writing)

    assert_difference('ApplicantSkill.count', -1) do
      delete inquiry_steps_applicant_skill_path(applicant_skill)
    end
  end
end
