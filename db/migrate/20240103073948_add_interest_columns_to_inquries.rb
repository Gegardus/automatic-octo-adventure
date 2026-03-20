# frozen_string_literal: true

class AddInterestColumnsToInquries < ActiveRecord::Migration[7.0]
  def change
    add_column :inquiries, :area_of_expertise, :string
    add_column :inquiries, :exciting_industry, :string
    add_column :inquiries, :strengths, :string
    add_column :inquiries, :weaknesses, :string
    add_column :inquiries, :problem_to_solve, :string
    add_column :inquiries, :position, :string
    add_column :inquiries, :company_founder, :boolean, null: false, default: false
    change_column_default :inquiries, :company_founder, from: false, to: nil
    add_column :inquiries, :founders_count, :string
    add_column :inquiries, :founders_connection, :string
    add_column :inquiries, :team_members_info, :string
    add_column :inquiries, :business_industry, :string
    add_column :inquiries, :idea_description, :string
    add_column :inquiries, :unique_selling_point, :string
    add_column :inquiries, :problem_solved, :string
    add_column :inquiries, :solution_users, :string
    add_column :inquiries, :product_description, :string
    add_column :inquiries, :main_features, :string
    add_column :inquiries, :money_to_invest, :string
    add_column :inquiries, :innovation_description, :string
    add_column :inquiries, :partner_investment, :string
    add_column :inquiries, :competitors, :string
    add_column :inquiries, :revenue_source, :string
    add_column :inquiries, :business_stage, :string
    add_column :inquiries, :target_customers, :string
    add_column :inquiries, :existing_business_idea, :boolean, null: false, default: false
    change_column_default :inquiries, :existing_business_idea, from: false, to: nil
  end
end
