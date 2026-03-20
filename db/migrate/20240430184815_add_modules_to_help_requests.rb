# frozen_string_literal: true

class AddModulesToHelpRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :help_requests, :module_name, :string
    add_column :help_requests, :module_section, :string
  end
end
