# frozen_string_literal: true

require 'test_helper'

class ApplicantEducationRecordControllerTest < ActionDispatch::IntegrationTest
  test '#index' do
    given_signed_in_as :bob

    get inquiry_steps_applicant_education_records_path

    assert_response :success

    assert_page_header 'Applicant education records'
  end

  test '#index with no records' do
    ApplicantEducationRecord.destroy_all

    given_signed_in_as :bob

    get inquiry_steps_applicant_education_records_path

    assert_response :success

    assert_text 'No applicant education records.'
  end

  test '#new' do
    given_signed_in_as :bob

    get new_inquiry_steps_applicant_education_record_path

    assert_response :success

    assert_page_header 'New Applicant education record'

    assert_form url: inquiry_steps_applicant_education_records_path
  end

  test '#create' do
    given_signed_in_as :bob

    assert_difference('ApplicantEducationRecord.count') do
      post inquiry_steps_applicant_education_records_path, params: {
        applicant_education_record: {
          concentration: 'Philosophy',
          degree_type: 'PhD',
          institution_name: 'Freeuni',
          start_date: '2002-09-09',
          end_date: '2004-09-09',
          graduated: true
      }
    }
    end

    assert_redirected_to inquiry_steps_applicant_education_records_path
    follow_redirect!

    assert_text 'Applicant education records'
  end

  test '#show' do
    given_signed_in_as :bob

    applicant_education_record = applicant_education_records(:bob_undergrad_degree)

    get inquiry_steps_applicant_education_record_path(applicant_education_record)

    assert_response :success
  end

  test '#edit' do
    given_signed_in_as :bob

    applicant_education_record = applicant_education_records(:bob_undergrad_degree)

    get edit_inquiry_steps_applicant_education_record_path(applicant_education_record)

    assert_response :success

    assert_text 'Edit'

    assert_form url: inquiry_steps_applicant_education_records_path
  end

  test '#update' do
    given_signed_in_as :bob

    applicant_education_record = applicant_education_records(:bob_undergrad_degree)

    put inquiry_steps_applicant_education_record_path(applicant_education_record), params: {
      applicant_education_record: {
        concentration: applicant_education_record.concentration,
        degree_type: applicant_education_record.degree_type,
        institution_name: applicant_education_record.institution_name,
        start_date: '2005-09-10',
        end_date: '2007-09-10',
        graduated: false
      }
    }

    assert_redirected_to inquiry_steps_applicant_education_records_path
  end

  test '#destroy' do
    given_signed_in_as :bob

    applicant_education_record = applicant_education_records(:bob_undergrad_degree)

    assert_difference('ApplicantEducationRecord.count', -1) do
      delete inquiry_steps_applicant_education_record_path(applicant_education_record)
    end
  end
end
