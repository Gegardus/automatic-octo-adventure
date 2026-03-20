# frozen_string_literal: true

require 'test_helper'

class YourInterestsControllerTest < ActionDispatch::IntegrationTest
  test '#show' do
    fitpal = inquiries(:fitpal)
    given_signed_in_as :bob

    get inquiry_steps_your_interest_path

    assert_text fitpal.area_of_expertise
  end

  test '#edit' do
    given_signed_in_as :bob

    get edit_inquiry_steps_your_interest_path

    assert_page_header 'Your interest'

    assert_form url: inquiry_steps_your_interest_path
  end

  test '#update' do # rubocop:disable Metrics/BlockLength
    fitpal = inquiries(:fitpal)
    given_signed_in_as :bob

    patch inquiry_steps_your_interest_path, params: {
      inquiry: {
        area_of_expertise: ['Tech'],
        which_industries_excite_you: ['Tech'],
        strengths: 'Problem solver',
        weaknesses: 'Being late',
        business_idea: 'Fitness AI app that monitors exercises',
        problem_to_solve: 'Physical health',
        position: 'Founder',
        company_founder: true,
        founders_count: 5,
        founders_connection: 'Uni friends',
        team_members_info: 'Info',
        business_industry: 'Tech',
        idea_description: 'Fitness AI app that monitors exercises',
        unique_selling_proposition: 'Getting in physical shape like never before',
        problem_solved: 'Health problems',
        solution_users: 'Everyone who has health problems',
        target_customers: 'Everyone who has health problems',
        business_stage: 'prototype',
        product_description: 'Fitness AI app that monitors exercises',
        main_features: 'Motion recorder',
        money_to_invest: '2 millions',
        innovation_description: 'Involves AI',
        partner_investment: 'Stocks',
        competitors: 'Other fitness content creators',
        revenue_source: 'App downloads',
        existing_business_idea: true,
        other_business_industry: nil
      }
    }

    assert_redirected_to inquiry_steps_your_interest_path

    assert_equal ['Tech'], fitpal.reload.area_of_expertise
  end
end
