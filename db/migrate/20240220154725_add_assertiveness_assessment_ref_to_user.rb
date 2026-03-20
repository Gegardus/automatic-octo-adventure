# frozen_string_literal: true

class AddAssertivenessAssessmentRefToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :assertiveness_assessment, null: true, foreign_key: true
  end
end
