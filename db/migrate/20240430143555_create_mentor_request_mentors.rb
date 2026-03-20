# frozen_string_literal: true

class CreateMentorRequestMentors < ActiveRecord::Migration[7.0]
  def change
    create_table :mentor_request_mentors do |t|
      t.references :mentor_request, null: false, foreign_key: true
      t.references :mentor, null: false, foreign_key: {
        to_table: :users
      }

      t.timestamps
    end
    remove_column :mentor_requests, :mentor_id, :integer
  end
end
