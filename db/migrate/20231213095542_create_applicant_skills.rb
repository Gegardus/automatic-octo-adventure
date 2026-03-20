# frozen_string_literal: true

class CreateApplicantSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :applicant_skills do |t|
      t.text :description, null: false
      t.string :proficiency_level, null: false
      t.string :skill_type, null: false
      t.string :certification, null: false
      t.integer :user_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
