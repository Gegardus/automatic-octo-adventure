# frozen_string_literal: true

class CreateRefiningYourIdeaModules < ActiveRecord::Migration[7.0]
  def change
    create_table :refining_your_idea_modules do |t|
      t.string :idea_description
      t.string :personal_passion
      t.string :target_audience
      t.string :product_service_address
      t.string :market_gaps
      t.string :potential_user_feedback
      t.string :technical_financial_feasibility
      t.string :scalability
      t.string :flexibility
      t.string :mission_statement
      t.string :vision_statement
      t.string :values
      t.string :value_proposition
      t.string :stage
      t.string :other_stage
      t.string :short_term_goal_1
      t.string :short_term_goal_2
      t.string :short_term_goal_3
      t.string :short_term_goal_4
      t.string :short_term_goal_5
      t.string :short_term_goal_6
      t.string :short_term_goal_7
      t.string :short_term_goal_8
      t.string :short_term_goal_9
      t.string :short_term_goal_10
      t.string :long_term_goal_1
      t.string :long_term_goal_2
      t.string :long_term_goal_3
      t.string :long_term_goal_4
      t.string :long_term_goal_5

      t.timestamps
    end

    add_reference :users, :refining_your_idea_module, foreign_key: true, null: true
  end
end
