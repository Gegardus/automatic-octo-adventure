# frozen_string_literal: true

require 'test_helper'

class ApplicantDetailTest < ActiveSupport::TestCase
  test 'validations' do
    applicant_detail = applicant_details(:bobs_details)
    applicant_detail.user.role = 'applicant'

    assert_invalid "can't be blank", pronouns: nil
    assert_invalid "can't be blank", country_of_origin: nil
    assert_invalid "can't be blank", country_of_application: nil
    assert_invalid "can't be blank", native_language: nil
    assert_invalid "can't be blank", tell_us_about_yourself: nil
    assert_invalid "can't be blank", current_address: nil

    assert_valid pronouns: 'They/Them'
    assert_valid country_of_origin: 'Georgia'
    assert_valid country_of_application: 'USA'
    assert_valid native_language: 'Georgian'
    assert_valid tell_us_about_yourself: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.'
    assert_valid current_address: '5A, Apartment 9, New-York, New Jersey, ZIP 11111'
  end
end
