# frozen_string_literal: true

class RenamePersonalSummary < ActiveRecord::Migration[7.0]
  def change
    rename_column :applicant_details, :personal_summary, :tell_us_about_yourself
    change_column :applicant_work_experiences, :responsibilities, :text # rubocop:disable Rails/ReversibleMigration
    rename_column :inquiries, :unique_selling_point, :unique_selling_proposition
  end
end
