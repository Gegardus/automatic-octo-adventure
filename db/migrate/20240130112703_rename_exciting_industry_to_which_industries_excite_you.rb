# frozen_string_literal: true

class RenameExcitingIndustryToWhichIndustriesExciteYou < ActiveRecord::Migration[7.0]
  def change
    rename_column :inquiries, :exciting_industry, :which_industries_excite_you
  end
end
