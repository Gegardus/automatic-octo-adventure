# frozen_string_literal: true

class CreateApplicantEducationRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :applicant_education_records do |t|
      t.string :degree_type, null: false
      t.string :institution_name, null: false
      t.string :concentration, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.boolean :graduated, null: false
      t.integer :user_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
