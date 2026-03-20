# frozen_string_literal: true

class AddPhoneAndMaritalStatusAndDateOfBirthToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phone, :string
    add_column :users, :marital_status, :string
    add_column :users, :date_of_birth, :date
    add_check_constraint :users, <<-SQL.squish
      (role <> 'applicant') OR
      (phone IS NOT NULL AND marital_status IS NOT NULL AND date_of_birth IS NOT NULL)
    SQL
  end
end
