# frozen_string_literal: true

class CreateApplicantDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :applicant_details do |t|
      t.string :pronouns, null: false
      t.string :country_of_origin, null: false
      t.string :country_of_application, null: false
      t.string :native_language, null: false
      t.string :linkedin_url, null: false
      t.text :personal_summary, null: false
      t.string :current_address, null: false
      t.integer :user_id, null: false, foreign_key: true

      t.timestamps
    end

    add_index :applicant_details, :user_id, unique: true

    add_foreign_key :applicant_details, :users
  end
end
