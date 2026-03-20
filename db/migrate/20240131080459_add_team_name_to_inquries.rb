# frozen_string_literal: true

class AddTeamNameToInquries < ActiveRecord::Migration[7.0]
  def change
    add_column :inquiries, :team_name, :string

    Inquiry.find_each do |inquiry|
      inquiry.update_columns(team_name: "team-#{inquiry.id}") # rubocop:disable Rails/SkipsModelValidations
    end

    remove_column :inquiries, :team_id, :integer
    drop_table :teams # rubocop:disable Rails/ReversibleMigration
    add_index :inquiries, :team_name, unique: true
  end
end
