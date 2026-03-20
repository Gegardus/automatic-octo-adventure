# frozen_string_literal: true

class CreateMentorRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :mentor_requests do |t|
      t.references :suv_application, null: false, foreign_key: true
      t.references :mentor, null: true, foreign_key: {
        to_table: :users
      }

      t.timestamps
    end

    remove_index :mentor_requests, name: 'index_mentor_requests_on_suv_application_id' # rubocop:disable Rails/ReversibleMigration
    add_index :mentor_requests, :suv_application_id, unique: true
  end
end
