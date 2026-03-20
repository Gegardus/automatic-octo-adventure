# frozen_string_literal: true

# Calculates assessments score
module BooleanScore
  extend ActiveSupport::Concern

  def calculate_score(method_names)
    method_names.map { |name| send(name) }.count(true)
  end
end
