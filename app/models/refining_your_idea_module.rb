# frozen_string_literal: true

# Collects information about refining your idea module
class RefiningYourIdeaModule < ApplicationRecord
  has_one :applicant, class_name: 'User', dependent: :destroy

  YOUR_IDEA_STEP_ATTRIBUTES = %i[
    idea_description
    personal_passion
    target_audience
    product_service_address
    market_gaps
    potential_user_feedback
    technical_financial_feasibility
    scalability
    flexibility
  ].freeze

  GOALS_STEP_ATTRIBUTES = %i[
    short_term_goal_1
    short_term_goal_2
    short_term_goal_3
    short_term_goal_4
    short_term_goal_5
    short_term_goal_6
    short_term_goal_7
    short_term_goal_8
    short_term_goal_9
    short_term_goal_10
    long_term_goal_1
    long_term_goal_2
    long_term_goal_3
    long_term_goal_4
    long_term_goal_5
  ].freeze

  REQUIRED_GOALS_STEP_ATTRIBUTES = GOALS_STEP_ATTRIBUTES - %i[
    short_term_goal_6
    short_term_goal_7
    short_term_goal_8
    short_term_goal_9
    short_term_goal_10
  ]

  ALL_ATTRIBUTES = YOUR_IDEA_STEP_ATTRIBUTES + GOALS_STEP_ATTRIBUTES

  validates(*YOUR_IDEA_STEP_ATTRIBUTES, presence: true, if: -> { persisted? && current_step == 'your_idea' })

  validates :mission_statement, presence: true, if: -> { your_idea_step_completed? && current_step == 'mission' }
  validates :vision_statement, presence: true, if: -> { mission_step_completed? && current_step == 'vision' }
  validates :values, presence: true, if: -> { vision_step_completed? && current_step == 'values' }
  validates :value_proposition, presence: true, if: -> { values_step_completed? && current_step == 'value_proposition' }
  validates(*REQUIRED_GOALS_STEP_ATTRIBUTES, presence: true,
                                             if: -> { value_proposition_step_completed? && current_step == 'goals' })
  validates :idea_description, :values, length: { maximum: 600 }
  validates :personal_passion, :target_audience, :product_service_address, :market_gaps, :potential_user_feedback,
            :technical_financial_feasibility, :scalability, :flexibility, length: { maximum: 70 }
  validates :mission_statement, :vision_statement, :value_proposition, length: { maximum: 300 }

  attribute :current_step

  def your_idea_step_completed?
    YOUR_IDEA_STEP_ATTRIBUTES.all? do |attr|
      send(attr).present?
    end
  end

  def mission_step_completed?
    mission_statement.present?
  end

  def vision_step_completed?
    vision_statement.present?
  end

  def values_step_completed?
    values.present?
  end

  def value_proposition_step_completed?
    value_proposition.present?
  end

  def completed?
    [your_idea_step_completed?, mission_step_completed?, vision_step_completed?, values_step_completed?,
     value_proposition_step_completed?].all?(true)
  end

  def goals_step_completed?
    REQUIRED_GOALS_STEP_ATTRIBUTES.all? do |attr|
      send(attr).present?
    end
  end
end
