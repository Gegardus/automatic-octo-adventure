# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.belongs_to :conversation, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end
