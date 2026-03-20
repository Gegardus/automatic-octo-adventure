# frozen_string_literal: true

require 'test_helper'

class BusinessModelsControllerTest < ActionDispatch::IntegrationTest
  test '#show' do
    given_signed_in_as :bob

    get business_model_path(section: 'business_plan')

    assert_response :success

    assert_page_header 'Business Plan'

    assert_form url: business_model_path(section: 'business_plan')
  end

  test '#show redirects to modules when next step is nil and all steps are skipped or completed' do
    given_signed_in_as :jim

    SkippedStep.create!(
      suv_application: users(:jim).suv_application,
      step_name: :business_plan,
      module_name: 'business_model'
    )

    get business_model_path(section: 'business_plan')

    assert_redirected_to modules_path
  end

  test '#update' do
    given_signed_in_as :bob

    patch business_model_path(section: 'building_business_plan'), params: {
      business_model: business_model_params
    }

    assert_redirected_to business_model_path(section: 'business_plan')
  end

  private

  def business_model_params # rubocop:disable Metrics/MethodLength
    {
      key_partners: 'Local suppliers, Distributors',
      key_activities: 'Product development, Marketing',
      value_proposition: 'High-quality products, Excellent customer service',
      customer_relationships: 'Personalized support, Loyalty programs',
      customer_segments: 'Young professionals, Small businesses',
      key_resources: 'Skilled workforce, Advanced technology',
      channels: 'Online store, Retail partnerships',
      cost_structure: 'Low production costs, Competitive pricing',
      revenue_streams: 'Product sales, Subscription services',
      strengths: 'Strong brand reputation',
      opportunities: 'Untapped market segments',
      weaknesses: 'Limited market reach',
      threats: 'Emerging competitors',
      new_entrants_threat: 'Low',
      buyers_bargaining_power: 'Medium',
      suppliers_bargaining_power: 'Low',
      substitute_products_or_services_threat: 'High',
      rivalry_among_existing_competitors: 'Medium',
      business_name_and_location: 'ABC Enterprises, New York',
      mission_and_vision_statement: 'Empowering customers to lead healthier lives',
      products_or_service_overview: 'Wide range of health supplements',
      objectives_summary: 'Become market leader in health industry',
      market_brief_overview: 'Growing health-conscious population',
      business_nature: 'Health and wellness products',
      legal_structure: 'Limited Liability Company (LLC)',
      business_history: 'Founded in 20XX by John Smith',
      industry_background: 'Health and wellness industry expertise',
      products_or_services_description: 'Vitamins, supplements, and natural remedies',
      unique_selling_point: '100% organic ingredients',
      pricing_strategy: 'Competitive pricing with volume discounts',
      lifecycle: 'Introduction, Growth, Maturity, Decline',
      research_and_development: 'Continuous innovation and product improvement',
      target_market: 'Health-conscious consumers aged 25-50',
      market_size: 'Estimated $XX billion industry',
      market_trends: 'Increasing demand for natural products',
      market_share: 'Captured X% of local market',
      customer_preference: 'Quality, Effectiveness, Brand reputation',
      competitor_analysis: 'SWOT analysis of key competitors',
      marketing_strategy: 'Digital marketing, Influencer partnerships',
      sales_model: 'Direct-to-consumer, Wholesale',
      sales_tactics: 'Promotions, Discounts, Bundles',
      sales_structure: 'In-house sales team, Channel partners',
      sales_activities: 'Cold calling, Email campaigns, Trade shows',
      management_overview: 'Experienced executives with industry background',
      organizational_structure: 'Hierarchical, Cross-functional teams',
      responsibilities: 'Clear roles and responsibilities defined',
      ownership: 'Privately owned by founding team',
      advisory: 'Industry advisors providing strategic guidance',
      supply_chain: 'Efficient sourcing and distribution network',
      production_workflow: 'Lean manufacturing processes',
      facilities: 'State-of-the-art production facilities',
      technology: 'Investment in cutting-edge technology',
      quality_control: 'Stringent quality assurance measures',
      start_up_capital: 'Initial investment of $X million',
      budgets: 'Budget allocated for marketing, R&D, operations',
      revenue_generation_timeline: 'Projected revenue growth over 5 years',
      startup_fees: 'Initial setup costs and legal fees',
      marketing_approach: 'Targeted advertising, Content marketing',
      hiring_strategy: 'Recruitment of top talent in the industry',
      marketing_contractors: 'External agencies for digital marketing',
      milestone_timeline: 'Key milestones and timelines for growth',
      pricing_structure: 'Tiered pricing model based on features',
      ip_protection: 'Patents filed for unique product formulations',
      target_audience: 'Demographic and psychographic profiles',
      sales_anticipation: 'Forecasted sales targets and growth',
      break_even_point: 'Projected break-even point in operations',
      ownership_structure: 'Equity ownership among founding team',
      hiring_forecast: 'Projected hiring needs over next year',
      management_compensation: 'Competitive salaries and bonuses for management team',
      share_canvas_learnings: fixture_file_upload('test/fixtures/files/placeholder.jpeg', 'image/jpeg'),
      share_forces_learnings: fixture_file_upload('test/fixtures/files/placeholder.jpeg', 'image/jpeg'),
      share_swot_learnings: fixture_file_upload('test/fixtures/files/placeholder.jpeg', 'image/jpeg')
    }
  end
end
