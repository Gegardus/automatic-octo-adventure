# frozen_string_literal: true

class CreateAssertivenessAssessments < ActiveRecord::Migration[7.0]
  def change
    create_table :assertiveness_assessments do |t|
      t.boolean :is_competitive, null: false
      t.boolean :is_decisive, null: false
      t.boolean :is_to_the_point, null: false
      t.boolean :is_impatient, null: false
      t.boolean :is_bold, null: false
      t.boolean :is_confronting, null: false
      t.boolean :is_challenging, null: false
      t.boolean :is_forthright, null: false
      t.boolean :is_fast_paced, null: false
      t.boolean :is_outspoken, null: false

      t.timestamps
    end
  end
end
