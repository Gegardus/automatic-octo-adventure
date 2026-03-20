# frozen_string_literal: true

class AddResponsivenessAssessmentRefToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :responsiveness_assessment, null: true, foreign_key: true
  end
end
