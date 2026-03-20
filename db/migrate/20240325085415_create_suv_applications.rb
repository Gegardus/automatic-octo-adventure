# frozen_string_literal: true

class CreateSuvApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :suv_applications do |t|
      t.string :team_name
      t.timestamps
    end
    add_reference :inquiries, :suv_application, null: true
    add_reference :users, :suv_application, null: true

    reversible do |dir|
      dir.up do
        update <<-SQL.squish
           INSERT INTO suv_applications (team_name, created_at, updated_at)
           SELECT team_name, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP FROM inquiries;
        SQL

        update <<-SQL.squish
           UPDATE inquiries
           SET suv_application_id = (
             SELECT id from suv_applications
             WHERE team_name = inquiries.team_name
           )
        SQL

        update <<-SQL.squish
           UPDATE users
           SET suv_application_id = (
             SELECT suv_application_id
             FROM inquiries
             WHERE inquiries.id = users.inquiry_id
           )
        SQL
        remove_index :inquiries, name: 'index_inquiries_on_suv_application_id'
      end
    end

    remove_column :inquiries, :team_name, :string
    remove_column :users, :inquiry_id, :integer

    add_index :suv_applications, :team_name, unique: true
    add_index :inquiries, :suv_application_id, unique: true

    change_column_null :suv_applications, :team_name, false
  end
end
