# frozen_string_literal: true

class AddStatusToInquiries < ActiveRecord::Migration[7.0]
  def change
    add_column :inquiries, :status, :string, null: false # rubocop:disable Rails/NotNullColumn
  end
end
