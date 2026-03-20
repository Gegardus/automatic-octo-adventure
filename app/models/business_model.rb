# frozen_string_literal: true

# Encapsulates everything for a business model
class BusinessModel < ApplicationRecord
  belongs_to :suv_application
  has_many :applicants, through: :suv_application

  attribute :applicant
  attribute :current_step

  has_one_attached :share_canvas_learnings
  has_one_attached :share_swot_learnings
  has_one_attached :share_forces_learnings

  BUILDING_BUSINESS_ATTRS = %w[key_partners key_activities value_proposition customer_relationships
                               customer_segments key_resources channels cost_structure revenue_streams
                               strengths opportunities weaknesses threats new_entrants_threat
                               buyers_bargaining_power suppliers_bargaining_power
                               substitute_products_or_services_threat rivalry_among_existing_competitors
                               share_canvas_learnings share_swot_learnings share_forces_learnings].freeze

  BUSINESS_PLAN_ATTRS = %w[
    business_name_and_location mission_and_vision_statement products_or_service_overview
    objectives_summary market_brief_overview business_nature legal_structure
    business_history industry_background products_or_services_description
    unique_selling_point pricing_strategy lifecycle research_and_development
    target_market market_size market_trends market_share customer_preference
    competitor_analysis marketing_strategy sales_model sales_tactics sales_structure
    sales_activities management_overview organizational_structure responsibilities
    ownership advisory supply_chain production_workflow facilities technology
    quality_control start_up_capital budgets revenue_generation_timeline startup_fees
    marketing_approach hiring_strategy marketing_contractors milestone_timeline
    pricing_structure ip_protection target_audience sales_anticipation break_even_point
    ownership_structure hiring_forecast management_compensation
  ].freeze

  validates(*BUILDING_BUSINESS_ATTRS, presence: true, if: -> { persisted? && current_step == 'building_business_plan' })
  validates(*BUSINESS_PLAN_ATTRS, presence: true, if: -> { persisted? && current_step == 'business_plan' })

  def steps_for_applicant
    Steps.new(
      title: 'Module 7: The Business Model',
      all_steps: [
        BusinessModelSteps::GettingStartedWithBusinessPlanStep.new(applicant: applicant),
        BusinessModelSteps::BuildingBusinessPlanStep.new(applicant: applicant),
        BusinessModelSteps::BusinessPlanStep.new(applicant: applicant)
      ]
    )
  end

  def building_business_plan_step_complete?
    BUILDING_BUSINESS_ATTRS.all? do |attr|
      send(attr).present?
    end && %i[share_canvas_learnings share_swot_learnings share_forces_learnings].all?(&:present?)
  end

  def business_plan_step_complete?
    BUSINESS_PLAN_ATTRS.all? do |attr|
      send(attr).present?
    end
  end

  def passed?
    building_business_plan_step_complete? && business_plan_step_complete?
  end
end
