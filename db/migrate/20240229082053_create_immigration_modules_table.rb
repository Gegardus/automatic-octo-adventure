# frozen_string_literal: true

class CreateImmigrationModulesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :immigration_modules, &:timestamps

    add_reference :users, :immigration_module, foreign_key: true
  end
end
