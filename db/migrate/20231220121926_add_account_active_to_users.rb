# frozen_string_literal: true

class AddAccountActiveToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :account_active, :boolean
    update "
      UPDATE users
      SET account_active = 'true'
    "
    change_column_null :users, :account_active, false
  end
end
