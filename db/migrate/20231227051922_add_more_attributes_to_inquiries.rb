# frozen_string_literal: true

class AddMoreAttributesToInquiries < ActiveRecord::Migration[7.0]
  def change
    add_column :inquiries, :reason_for_interest, :string
    add_column :inquiries, :where_did_you_hear_about_us, :string
    add_column :inquiries, :startup_location, :string
  end
end
