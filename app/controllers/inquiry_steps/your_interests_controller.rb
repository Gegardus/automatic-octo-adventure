# frozen_string_literal: true

module InquirySteps
  class YourInterestsController < ApplicationController
    authorized_when { current_user.applicant? }
    include StepsForInquiry
    before_action -> { setup_inquiry_for_step(:your_interest) }

    def edit
      @inquiry.assign_attributes(your_interest_inquiry_params)
    end

    def update
      @inquiry.update(your_interest_inquiry_params)

      respond_with @inquiry, location: inquiry_steps_your_interest_path
    end

    private

    def your_interest_inquiry_params
      params.fetch(:inquiry, {}).permit(
        :strengths, :weaknesses, :business_idea,
        :problem_to_solve, :position, :company_founder, :founders_count, :founders_connection,
        :team_members_info, :business_industry, :idea_description, :unique_selling_proposition,
        :problem_solved, :solution_users, :target_customers, :business_stage, :product_description,
        :main_features, :money_to_invest, :innovation_description, :partner_investment, :competitors,
        :revenue_source, :existing_business_idea, :other_business_industry,
        { area_of_expertise: [], which_industries_excite_you: [] }
      )
    end
  end
end
