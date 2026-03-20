# frozen_string_literal: true

class AddNullFalseOnMaritalStatusInApplicantDetails < ActiveRecord::Migration[7.0]
  def up
    change_column :applicant_details, :marital_status, :string, null: false
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
