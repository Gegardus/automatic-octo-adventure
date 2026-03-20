# frozen_string_literal: true

class RemoveApplicantInquiries < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :inquiry, null: true

    reversible do |dir|
      dir.up do
        update "
          UPDATE users
          SET inquiry_id = (
            SELECT inquiry_id
            FROM applicant_inquiries
            WHERE applicant_id = users.id
          )
        "
      end
    end

    drop_table :applicant_inquiries # rubocop:disable Rails/ReversibleMigration
  end
end
