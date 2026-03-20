# frozen_string_literal: true

class AddSubmissionConfirmedAndSubmissionDateAndSubmissionFullNameToInquiries < ActiveRecord::Migration[7.0]
  def change
    add_column :inquiries, :submission_confirmed, :boolean, null: false # rubocop:disable Rails/NotNullColumn
    add_column :inquiries, :submission_date, :date
    add_column :inquiries, :submission_full_name, :string
  end
end
