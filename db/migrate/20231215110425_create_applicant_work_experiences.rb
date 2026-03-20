# frozen_string_literal: true

class CreateApplicantWorkExperiences < ActiveRecord::Migration[7.0]
  def change
    create_table :applicant_work_experiences do |t|
      t.string :company, null: false
      t.string :job_title, null: false
      t.string :responsibilities, null: false
      t.string :tenure, null: false
      t.string :location, null: false
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
