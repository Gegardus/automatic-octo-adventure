# frozen_string_literal: true

class CreateInquiries < ActiveRecord::Migration[7.0]
  def change
    create_table :inquiries do |t|
      t.text :business_idea

      t.timestamps
    end
  end
end
