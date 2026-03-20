# frozen_string_literal: true

# Allows skipping a step for a user or suv_application as a whole
class SkippedStep < ApplicationRecord
  belongs_to :suv_application, optional: true
  belongs_to :user, optional: true

  validates :step_name, :module_name, presence: true
end
