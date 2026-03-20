# frozen_string_literal: true

class AddOtherBusinessIndustryToInquiries < ActiveRecord::Migration[7.0]
  def change
    add_column :inquiries, :other_business_industry, :string
  end
end
