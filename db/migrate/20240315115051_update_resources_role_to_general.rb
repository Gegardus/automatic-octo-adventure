# frozen_string_literal: true

class UpdateResourcesRoleToGeneral < ActiveRecord::Migration[6.1]
  def change
    add_column :resources, :application_module, :string, null: false, default: 'general'
    change_column_default :resources, :application_module, from: 'general', to: nil
  end
end
