# frozen_string_literal: true

class CreateResponsivenessAssessments < ActiveRecord::Migration[7.0]
  def change
    create_table :responsiveness_assessments do |t|
      t.boolean :is_open, null: false
      t.boolean :is_approachable, null: false
      t.boolean :is_outgoing, null: false
      t.boolean :is_intuitive, null: false
      t.boolean :is_informal, null: false
      t.boolean :is_warm, null: false
      t.boolean :is_casual, null: false
      t.boolean :is_animated, null: false
      t.boolean :is_random, null: false
      t.boolean :is_unstructured, null: false

      t.timestamps
    end
  end
end
