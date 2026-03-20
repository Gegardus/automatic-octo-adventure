# frozen_string_literal: true

class CreateImmigrationQuizTable < ActiveRecord::Migration[7.0]
  def change
    create_table :immigration_quizzes do |t|
      t.string :tech_hub_city
      t.string :primary_purpose_for_sin
      t.string :responsible_for_driving_license
      t.string :ahcip_health_coverage
      t.string :waiting_period_for_health_coverage
      t.string :renowned_blue_nose_marathon
      t.string :known_university_for_stem_program
      t.string :vancouver_city_province
      t.string :responsible_for_monetary_policy
      t.string :income_tax_filing_deadline
      t.string :quebec_g_license_equivalent
      t.string :sin_issuance_facilitator
      t.string :known_for_cowboy_culture
      t.string :ubc_citys_location
      t.string :insurance_option_for_newcomer
      t.string :french_speaking_province
      t.string :not_part_of_stem_field
      t.string :offers_ohip_health_coverage
      t.string :not_major_tech_hub
      t.string :employability_step
      t.string :apartment_leasing_requirement
      t.string :driving_license_without_inexperienced_driver
      t.string :post_primary_school_education
      t.string :not_tip_for_newcomer
      t.string :tax_collection_administration
      t.string :ged_education_significance

      t.timestamps
    end

    add_reference :immigration_modules, :current_immigration_quiz, foreign_key: { to_table: :immigration_quizzes }
    add_reference :immigration_quizzes, :immigration_module, foreign_key: true
  end
end
