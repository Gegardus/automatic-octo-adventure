# frozen_string_literal: true

require 'test_helper'

class ApplicantDetailControllerTest < ActionDispatch::IntegrationTest
  test '#show redirects to new_applicant_detail_path when applicant_detail is nil' do
    given_signed_in_as(:charlie)

    users(:charlie).update!(suv_application: SuvApplication.create!(team_name: 'Charlies angels'))

    get inquiry_steps_applicant_detail_path

    assert_redirected_to new_inquiry_steps_applicant_detail_path
  end

  test 'only applicants can access this controller' do
    given_signed_in_as(:dom)

    get inquiry_steps_applicant_detail_path

    assert_response :unauthorized
  end

  test '#show' do
    bob = given_signed_in_as(:bob)

    get inquiry_steps_applicant_detail_path

    assert_text bob.applicant_detail.pronouns
    assert_text bob.applicant_detail.country_of_origin
  end

  test '#new' do
    given_signed_in_as(:charlie)

    users(:charlie).update!(suv_application: SuvApplication.create!(team_name: 'Charlies angels'))

    get new_inquiry_steps_applicant_detail_path

    assert_page_header 'New Applicant Detail'

    assert_form url: inquiry_steps_applicant_detail_path
  end

  test '#new redirects to edit if a user already has applicant_detail' do
    bob = given_signed_in_as(:bob)

    get new_inquiry_steps_applicant_detail_path

    assert_redirected_to edit_inquiry_steps_applicant_detail_path

    assert bob.reload.applicant_detail
  end

  test '#edit' do
    given_signed_in_as(:bob)

    get edit_inquiry_steps_applicant_detail_path

    assert_page_header 'Edit Applicant Detail'

    assert_form url: inquiry_steps_applicant_detail_path
  end

  test '#create' do
    charlie = given_signed_in_as(:charlie)

    users(:charlie).update!(suv_application: SuvApplication.create!(team_name: 'Charlies angels'))

    assert_difference 'ApplicantDetail.count' do
      post inquiry_steps_applicant_detail_path, params: {
        applicant_detail: valid_params
      }

      assert_redirected_to inquiry_steps_applicant_detail_path
    end

    assert_success_alert 'Applicant detail was successfully created.'

    assert_not_nil charlie.applicant_detail
  end

  test '#update' do
    given_signed_in_as(:bob)

    put inquiry_steps_applicant_detail_path, params: {
      applicant_detail: valid_params
    }

    assert_redirected_to inquiry_steps_applicant_detail_path

    assert_success_alert 'Applicant detail was successfully updated.'
  end

  private

  def valid_params # rubocop:disable Metrics/MethodLength
    {
      pronouns: 'They/Them',
      country_of_origin: 'Georgia',
      country_of_application: 'USA',
      native_language: 'Georgian',
      linkedin_url: 'https://www.linkedin.com/in/bob-dole/',
      tell_us_about_yourself: 'I am a great bussinesman',
      current_address: '5A, Apartment 9, New-York, New Jersey, ZIP 11111',
      marital_status: 'married',
      language_test_result_file: fixture_file_upload('test/fixtures/files/placeholder.jpeg', 'image/jpeg')
    }
  end
end
