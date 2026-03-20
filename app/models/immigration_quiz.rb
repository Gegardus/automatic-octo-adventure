# frozen_string_literal: true

# The final quiz at the end of the step 1
class ImmigrationQuiz < ApplicationRecord # rubocop:disable Metrics/ClassLength
  include BooleanScore
  belongs_to :immigration_module

  QUESTIONS = %i[
    tech_hub_city
    primary_purpose_for_sin
    responsible_for_driving_license
    ahcip_health_coverage
    waiting_period_for_health_coverage
    renowned_blue_nose_marathon
    known_university_for_stem_program
    vancouver_city_province
    responsible_for_monetary_policy
    income_tax_filing_deadline
    quebec_g_license_equivalent
    sin_issuance_facilitator
    known_for_cowboy_culture
    ubc_citys_location
    insurance_option_for_newcomer
    french_speaking_province
    not_part_of_stem_field
    offers_ohip_health_coverage
    not_major_tech_hub
    employability_step
    apartment_leasing_requirement
    driving_license_without_inexperienced_driver
    post_primary_school_education
    not_tip_for_newcomer
    tax_collection_administration
    ged_education_significance
  ].freeze

  LABELS = {
    tech_hub_city: {
      toronto: 'Toronto',
      halifax: 'Halifax',
      winnipeg: 'Winnipeg',
      calgary: 'Calgary',
      label: 'Which Canadian city is known for being a major tech hub?'
    },
    primary_purpose_for_sin: {
      voting_elections: 'Voting in elections',
      bank_account: 'Opening a bank account',
      securing_employment: 'Securing employment',
      driving_license: 'Applying for a driving license',
      label: 'What is the primary purpose of the Social Insurance Number (SIN) in Canada?'
    },
    responsible_for_driving_license: {
      dmv_canada: 'DMV Canada',
      drive_test: 'DriveTest',
      canadian_transport_agency: 'Canadian Transport Agency',
      service_canada_license: 'Service Canada',
      label: 'Which organization is responsible for issuing driving licenses in Canada?'
    },
    ahcip_health_coverage: {
      british_columbia: 'British Columbia',
      quebec_coverage: 'Quebec',
      alberta_coverage: 'Alberta',
      manitoba_coverage: 'Manitoba',
      label: 'Which province offers the AHCIP health coverage?'
    },
    waiting_period_for_health_coverage: {
      immediately: 'Immediately upon arrival',
      one_month: 'One month',
      three_months: 'Three months',
      six_months: 'Six months',
      label: 'When is the typical waiting period for newcomers before they receive provincial health coverage?'
    },
    renowned_blue_nose_marathon: {
      ontario_marathon: 'Ontario',
      nova_scotia: 'Nova Scotia',
      saskatchewan: 'Saskatchewan',
      yukon: 'Yukon',
      label: 'Which province is renowned for its Blue Nose Marathon?'
    },
    known_university_for_stem_program: {
      mcgill_university: 'McGill University',
      university_of_ottawa: 'University of Ottawa',
      university_of_toronto: 'University of Toronto',
      university_of_calgary: 'University of Calgary',
      label: 'Which Canadian university is known worldwide for its STEM programs and research?'
    },
    vancouver_city_province: {
      alberta_province: 'Alberta',
      manitoba_province: 'Manitoba',
      british_columbia_province: 'British Columbia',
      newfoundland_and_labrador: 'Newfoundland and Labrador',
      label: 'In which province can you find the city of Vancouver?'
    },
    responsible_for_monetary_policy: {
      transport_canada: 'Transport Canada',
      revenue_canada: 'Revenue Canada',
      bank_of_canada: 'Bank of Canada',
      health_canada: 'Health Canada',
      label: 'Which Canadian federal institution is primarily responsible for monetary policy?'
    },
    income_tax_filing_deadline: {
      january_1st: 'January 1st',
      march_31st: 'March 31st',
      april_30th: 'April 30th',
      july_15th: 'July 15th',
      label: 'When is the general deadline for individual income tax filing in Canada?'
    },
    quebec_g_license_equivalent: {
      class_5: 'Class 5',
      class_7: 'Class 7',
      class_4: 'Class 4',
      class_1: 'Class 1',
      label: 'What is the Quebec equivalent to the G license in other parts of Canada?'
    },
    sin_issuance_facilitator: {
      canadian_air_transport: 'Canadian Air Transport',
      immigration_refugees_and_citizenship_canada: 'Immigration, Refugees and Citizenship Canada',
      service_canada: 'Service Canada',
      canada_border_services_agency: 'Canada Border Services Agency',
      label: 'Which body in Canada facilitates the issuance of the Social Insurance Number (SIN) at airports?'
    },
    known_for_cowboy_culture: {
      quebec: 'Quebec',
      alberta: 'Alberta',
      ontario: 'Ontario',
      prince_edward_island: 'Prince Edward Island',
      label: 'Which province is known for its Cowboy culture?'
    },
    ubc_citys_location: {
      victoria: 'Victoria',
      kelowna: 'Kelowna',
      vancouver: 'Vancouver',
      burnaby: 'Burnaby',
      label: 'In which city is the University of British Columbia primarily located?'
    },
    insurance_option_for_newcomer: {
      provincial_insurance: 'Provincial Insurance',
      travel_insurance_extension: 'Travel Insurance Extension',
      employee_benefits: 'Employee Benefits',
      private_health_insurance_for_new_immigrants: 'Private Health Insurance for New Immigrants',
      label: 'Which insurance option is specifically designed for newcomers during their provincial
              coverage waiting period?'
    },
    french_speaking_province: {
      province_of_new_brunswick: 'New Brunswick',
      province_of_ontario: 'Ontario',
      province_of_quebec: 'Quebec',
      province_of_manitoba: 'Manitoba',
      label: 'Which province is home to the French-speaking majority city of Montreal?'
    },
    not_part_of_stem_field: {
      sociology: 'Sociology',
      technology: 'Technology',
      engineering: 'Engineering',
      mathematics: 'Mathematics',
      label: 'Which of the following is not a part of the STEM fields?'
    },
    offers_ohip_health_coverage: {
      ontario_coverage: 'Ontario',
      saskatchewan_coverage: 'Saskatchewan',
      prince_edward_island_coverage: 'Prince Edward Island',
      nunavut_coverage: 'Nunavut',
      label: 'Which province offers the OHIP health coverage plan?'
    },
    not_major_tech_hub: {
      calgary_city: 'Calgary',
      toronto_city: 'Toronto',
      vancouver_city: 'Vancouver',
      montreal_city: 'Montreal',
      label: 'Which of these Canadian cities is not known as a major tech hub among the following options?'
    },
    employability_step: {
      securing_a_canadian_driving_license_immediately: 'Securing a Canadian driving license immediately',
      opening_a_bank_account_with_a_large_deposit: 'Opening a bank account with a large deposit',
      getting_a_social_insurance_number_sin: 'Getting a Social Insurance Number (SIN)',
      buying_property_in_canada: 'Buying property in Canada',
      label: 'For newcomers to Canada, which is an essential step to ensure employability and access
              to certain government benefits?'
    },
    apartment_leasing_requirement: {
      owning_a_pet: 'Owning a pet',
      having_a_canadian_driving_license: 'Having a Canadian driving license',
      providing_proof_of_employment_or_income: 'Providing proof of employment or income',
      being_fluent_in_french: 'Being fluent in French',
      label: "What is a common requirement when leasing an apartment in Canada's major cities?"
    },
    driving_license_without_inexperienced_driver: {
      g1: 'G1',
      g3: 'G3',
      g: 'G',
      learners_permit: "Learner's Permit",
      label: 'Which driving license in Ontario allows you to drive without another experienced driver in the car?'
    },
    post_primary_school_education: {
      middle_school: 'Middle school',
      high_school: ' High school',
      college: 'College',
      graduate_school: 'Graduate school',
      label: 'In Canada, which type of education follows after primary school and precedes post-secondary education?'
    },
    not_tip_for_newcomer: {
      explore_and_understand_canadian_cultural_norms: 'Explore and understand Canadian cultural norms',
      avoid_acquiring_a_social_insurance_number: 'Avoid acquiring a Social Insurance Number',
      join_local_community_groups_to_integrate_faster: 'Join local community groups to integrate faster',
      understand_the_local_public_transportation_system: 'Understand the local public transportation system',
      label: 'Which is NOT a tip recommended for newcomers to Canada?'
    },
    tax_collection_administration: {
      canada_bank: 'Bank of Canada',
      canadian_revenue_agency_cra: 'Canadian Revenue Agency (CRA)',
      federal_taxation_bureau_ftb: 'Federal Taxation Bureau (FTB)',
      department_of_finances: 'Department of Finances',
      label: 'In Canada, which federal institution is primarily responsible for tax collection and administration?'
    },
    ged_education_significance: {
      grade_equivalency_diploma_for_high_school: "It's a grade equivalency diploma for high school.",
      diploma_for_postgraduate_education: "It's a diploma for postgraduate education.",
      entrance_exam_for_canadian_universities: "It's an entrance exam for Canadian universities.",
      diploma_for_vocational_training: "It's a diploma for vocational training.",
      label: 'What is the significance of GED in the Canadian education system?'
    }
  }.freeze

  TECH_CITIES = %w[calgary toronto winnipeg halifax].freeze
  SIN_PURPOSES = %w[voting_elections bank_account securing_employment driving_license].freeze
  RESPONSIBLE_FOR_DRIVING_LICENCES = %w[dmv_canada drive_test canadian_transport_agency service_canada_license].freeze
  HEALTH_COVERAGES = %w[british_columbia quebec_coverage alberta_coverage manitoba_coverage].freeze
  WAITING_PERIODS = %w[immediately one_month three_months six_months].freeze
  MARATHONS = %w[ontario_marathon nova_scotia saskatchewan yukon].freeze
  STEM_UNIVERSITIES = %w[mcgill_university university_of_ottawa university_of_toronto university_of_calgary].freeze
  VANCOUVER_PROVINCES = %w[alberta_province manitoba_province british_columbia_province
                           newfoundland_and_labrador].freeze
  MONETARY_POLICIES = %w[transport_canada revenue_canada bank_of_canada health_canada].freeze
  TAX_FILING_DEADLINES = %w[january_1st march_31st april_30th july_15th].freeze
  G_LICENSES = %w[class_5 class_7 class_4 class_1].freeze
  SIN_FACILITATORS = %w[canadian_air_transport immigration_refugees_and_citizenship_canada service_canada
                        canada_border_services_agency].freeze
  COWBOY_CULTURES = %w[quebec alberta ontario prince_edward_island].freeze
  UBC_CITY_LOCATIONS = %w[victoria kelowna vancouver burnaby].freeze
  INSURANCE_OPTIONS = %w[provincial_insurance travel_insurance_extension employee_benefits
                         private_health_insurance_for_new_immigrants].freeze
  FRENCH_SPEAKING_PROVINCES = %w[province_of_new_brunswick province_of_ontario province_of_quebec
                                 province_of_manitoba].freeze
  NOT_STEM_FIELDS = %w[sociology technology engineering mathematics].freeze
  OHIP_HELATH_COVERAGES = %w[ontario_coverage saskatchewan_coverage prince_edward_island_coverage
                             nunavut_coverage].freeze
  NOT_TECH_CITIES = %w[calgary_city toronto_city vancouver_city montreal_city].freeze
  EMPLOYABILITY_STEPS = %w[securing_a_canadian_driving_license_immediately opening_a_bank_account_with_a_large_deposit
                           getting_a_social_insurance_number_sin buying_property_in_canada].freeze
  APARTMENT_LEASING_REQUIREMENTS = %w[owning_a_pet having_a_canadian_driving_license
                                      providing_proof_of_employment_or_income being_fluent_in_french].freeze
  INDEXPERIENCED_DRIVING_LICENSES = %w[g1 g3 g learners_permit].freeze
  POST_PRIMARY_SCHOOL_EDUCATIONS = %w[middle_school high_school college graduate_school].freeze
  NOT_NEWCOMER_TIPS = %w[explore_and_understand_canadian_cultural_norms avoid_acquiring_a_social_insurance_number
                         join_local_community_groups_to_integrate_faster
                         understand_the_local_public_transportation_system].freeze
  TAX_COLLECTION_ADMINISTRATIONS = %w[canada_bank canadian_revenue_agency_cra federal_taxation_bureau_ftb
                                      department_of_finances].freeze
  GED_EDUCATION_SIGNIFICANCES = %w[grade_equivalency_diploma_for_high_school diploma_for_postgraduate_education
                                   entrance_exam_for_canadian_universities diploma_for_vocational_training].freeze

  enum tech_hub_city: TECH_CITIES.to_h { |type| [type, type] }
  enum primary_purpose_for_sin: SIN_PURPOSES.to_h { |type| [type, type] }
  enum responsible_for_driving_license: RESPONSIBLE_FOR_DRIVING_LICENCES.to_h { |type| [type, type] }
  enum ahcip_health_coverage: HEALTH_COVERAGES.to_h { |type| [type, type] }
  enum waiting_period_for_health_coverage: WAITING_PERIODS.to_h { |type| [type, type] }
  enum renowned_blue_nose_marathon: MARATHONS.to_h { |type| [type, type] }
  enum known_university_for_stem_program: STEM_UNIVERSITIES.to_h { |type| [type, type] }
  enum vancouver_city_province: VANCOUVER_PROVINCES.to_h { |type| [type, type] }
  enum responsible_for_monetary_policy: MONETARY_POLICIES.to_h { |type| [type, type] }
  enum income_tax_filing_deadline: TAX_FILING_DEADLINES.to_h { |type| [type, type] }
  enum quebec_g_license_equivalent: G_LICENSES.to_h { |type| [type, type] }
  enum sin_issuance_facilitator: SIN_FACILITATORS.to_h { |type| [type, type] }
  enum known_for_cowboy_culture: COWBOY_CULTURES.to_h { |type| [type, type] }
  enum ubc_citys_location: UBC_CITY_LOCATIONS.to_h { |type| [type, type] }
  enum insurance_option_for_newcomer: INSURANCE_OPTIONS.to_h { |type| [type, type] }
  enum french_speaking_province: FRENCH_SPEAKING_PROVINCES.to_h { |type| [type, type] }
  enum not_part_of_stem_field: NOT_STEM_FIELDS.to_h { |type| [type, type] }
  enum offers_ohip_health_coverage: OHIP_HELATH_COVERAGES.to_h { |type| [type, type] }
  enum not_major_tech_hub: NOT_TECH_CITIES.to_h { |type| [type, type] }
  enum employability_step: EMPLOYABILITY_STEPS.to_h { |type| [type, type] }
  enum apartment_leasing_requirement: APARTMENT_LEASING_REQUIREMENTS.to_h { |type| [type, type] }
  enum driving_license_without_inexperienced_driver: INDEXPERIENCED_DRIVING_LICENSES.to_h { |type| [type, type] }
  enum post_primary_school_education: POST_PRIMARY_SCHOOL_EDUCATIONS.to_h { |type| [type, type] }
  enum not_tip_for_newcomer: NOT_NEWCOMER_TIPS.to_h { |type| [type, type] }
  enum tax_collection_administration: TAX_COLLECTION_ADMINISTRATIONS.to_h { |type| [type, type] }
  enum ged_education_significance: GED_EDUCATION_SIGNIFICANCES.to_h { |type| [type, type] }

  def score
    calculate_score(%i[toronto? securing_employment? drive_test? alberta_coverage? three_months? nova_scotia?
                       university_of_toronto? british_columbia_province? bank_of_canada? april_30th? class_5?
                       service_canada? alberta? vancouver? private_health_insurance_for_new_immigrants?
                       province_of_quebec? sociology? ontario_coverage? calgary_city?
                       getting_a_social_insurance_number_sin? providing_proof_of_employment_or_income? g? high_school?
                       avoid_acquiring_a_social_insurance_number? canadian_revenue_agency_cra?
                       grade_equivalency_diploma_for_high_school?])
  end

  def passed?
    score >= 8
  end
end
