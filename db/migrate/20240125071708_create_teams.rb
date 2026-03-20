# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :teams, :name, unique: true

    # Inquiry.find_each do |inquiry|
    #   inquiry.update!(team: Team.new(name: "team-#{inquiry.id}"))
    # end
    add_reference :inquiries, :team, null: true, foreign_key: true
  end
end
