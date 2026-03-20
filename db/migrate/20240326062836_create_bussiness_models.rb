# frozen_string_literal: true

class CreateBussinessModels < ActiveRecord::Migration[7.0]
  def change
    create_table :business_models do |t|
      t.string :key_partners
      t.string :key_activities
      t.string :value_proposition
      t.string :customer_relationships
      t.string :customer_segments
      t.string :key_resources
      t.string :channels
      t.string :cost_structure
      t.string :revenue_streams
      t.string :strengths
      t.string :opportunities
      t.string :weaknesses
      t.string :threats
      t.string :new_entrants_threat
      t.string :buyers_bargaining_power
      t.string :suppliers_bargaining_power
      t.string :substitute_products_or_services_threat
      t.string :rivalry_among_existing_competitors
      t.string :business_name_and_location
      t.string :mission_and_vision_statement
      t.string :products_or_service_overview
      t.string :objectives_summary
      t.string :market_brief_overview
      t.string :business_nature
      t.string :legal_structure
      t.string :business_history
      t.string :industry_background
      t.string :products_or_services_description
      t.string :unique_selling_point
      t.string :pricing_strategy
      t.string :lifecycle
      t.string :research_and_development
      t.string :target_market
      t.string :market_size
      t.string :market_trends
      t.string :market_share
      t.string :customer_preference
      t.string :competitor_analysis
      t.string :marketing_strategy
      t.string :sales_model
      t.string :sales_tactics
      t.string :sales_structure
      t.string :sales_activities
      t.string :management_overview
      t.string :organizational_structure
      t.string :responsibilities
      t.string :ownership
      t.string :advisory
      t.string :supply_chain
      t.string :production_workflow
      t.string :facilities
      t.string :technology
      t.string :quality_control
      t.string :start_up_capital
      t.string :budgets
      t.string :revenue_generation_timeline
      t.string :startup_fees
      t.string :marketing_approach
      t.string :hiring_strategy
      t.string :marketing_contractors
      t.string :milestone_timeline
      t.string :pricing_structure
      t.string :ip_protection
      t.string :target_audience
      t.string :sales_anticipation
      t.string :break_even_point
      t.string :ownership_structure
      t.string :hiring_forecast
      t.string :management_compensation

      t.timestamps
    end

    add_reference :business_models, :suv_application, null: true, index: true
  end
end
