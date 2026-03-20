# frozen_string_literal: true

# this model captures the skills of the applicant
class ApplicantSkill < ApplicationRecord
  belongs_to :user

  PROFICIENCY_LEVELS = %w[beginner intermediate professional expert].freeze

  enum proficiency_level: PROFICIENCY_LEVELS.to_h { |type| [type, type] }

  validates :description, :proficiency_level, :skill_type, :certification, presence: true
end
