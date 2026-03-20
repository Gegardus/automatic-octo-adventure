# frozen_string_literal: true

class CreateApplicantInquiries < ActiveRecord::Migration[7.0]
  def change
    create_table :applicant_inquiries do |t|
      t.belongs_to :applicant, null: false, foreign_key: {
        to_table: :users
      }
      t.belongs_to :inquiry, null: false, foreign_key: true

      t.timestamps
    end
  end
end
