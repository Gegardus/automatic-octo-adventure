# frozen_string_literal: true

require 'test_helper'

class ImmigrationQuizzesControllerTest < ActionDispatch::IntegrationTest
  test '#new' do
    given_signed_in_as :bob

    get new_immigration_quizzes_path

    assert_response :success

    assert_page_header 'Final quiz'

    assert_form url: immigration_quizzes_path
  end

  test '#create' do # rubocop:disable Metrics/BlockLength
    given_signed_in_as :bob

    post immigration_quizzes_path, params: {
      immigration_quiz: {
        tech_hub_city: :toronto,
        primary_purpose_for_sin: :securing_employment,
        responsible_for_driving_license: :drive_test,
        ahcip_health_coverage: :alberta_coverage,
        waiting_period_for_health_coverage: :three_months,
        renowned_blue_nose_marathon: :nova_scotia,
        known_university_for_stem_program: :university_of_toronto,
        vancouver_city_province: :british_columbia_province,
        responsible_for_monetary_policy: :bank_of_canada,
        income_tax_filing_deadline: :april_30th,
        quebec_g_license_equivalent: :class_5,
        sin_issuance_facilitator: :service_canada,
        known_for_cowboy_culture: :alberta,
        ubc_citys_location: :vancouver,
        insurance_option_for_newcomer: :employee_benefits,
        french_speaking_province: :province_of_quebec,
        not_part_of_stem_field: :sociology,
        offers_ohip_health_coverage: :ontario_coverage,
        not_major_tech_hub: :calgary_city,
        employability_step: :buying_property_in_canada,
        apartment_leasing_requirement: :providing_proof_of_employment_or_income,
        driving_license_without_inexperienced_driver: :g,
        post_primary_school_education: :high_school,
        not_tip_for_newcomer: :avoid_acquiring_a_social_insurance_number,
        tax_collection_administration: :canada_bank,
        ged_education_significance: :grade_equivalency_diploma_for_high_school
       }
    }

    assert_success_alert 'Final quiz passed!'
  end

  test '#create fails' do
    given_signed_in_as :bob

    post immigration_quizzes_path, params: {
      immigration_quiz: {
        tech_hub_city: :toronto,
        primary_purpose_for_sin: :securing_employment,
        responsible_for_driving_license: :drive_test,
        ahcip_health_coverage: :alberta_coverage,
        waiting_period_for_health_coverage: :three_months,
        renowned_blue_nose_marathon: :nova_scotia,
        known_university_for_stem_program: :university_of_toronto
       }
    }

    assert_danger_alert 'Final quiz failed, at least 8 questions must be answered correctly. Please try again'
  end
end
