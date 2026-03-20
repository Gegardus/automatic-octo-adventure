# frozen_string_literal: true

class CreateHelpRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :help_requests do |t|
      t.text :details, null: false
      t.references :suv_application, null: false, foreign_key: true
      t.references :conversation, null: false, foreign_key: true
      t.references :admin, null: true, foreign_key: {
        to_table: :users
      }

      t.timestamps
    end
  end
end
