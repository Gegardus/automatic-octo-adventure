# frozen_string_literal: true

class CreateSkippedSteps < ActiveRecord::Migration[7.0]
  def change
    create_table :skipped_steps do |t|
      t.references :suv_application, foreign_key: true
      t.references :user, foreign_key: true
      t.string :step_name, null: false
      t.string :module_name, null: false

      t.timestamps
    end
  end
end
