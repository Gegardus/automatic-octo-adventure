# frozen_string_literal: true

class ChangeSomeColumnsToArrays < ActiveRecord::Migration[7.0]
  def up
    change_column :inquiries, :area_of_expertise, :text, array: true,
                                                         using: 'array[area_of_expertise]::text[]'
    change_column :inquiries, :exciting_industry, :text, array: true,
                                                         using: 'array[exciting_industry]::text[]'
  end

  def down; end
end
