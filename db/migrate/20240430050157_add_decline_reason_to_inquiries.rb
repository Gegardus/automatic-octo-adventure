# frozen_string_literal: true

class AddDeclineReasonToInquiries < ActiveRecord::Migration[7.0]
  def change
    add_column :inquiries, :decline_reason, :string
  end
end
