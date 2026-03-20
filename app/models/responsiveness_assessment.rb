# frozen_string_literal: true

# Estimates applicant responsiveness
class ResponsivenessAssessment < ApplicationRecord
  include BooleanScore

  QUESTIONS = %i[
    is_open
    is_approachable
    is_outgoing
    is_intuitive
    is_informal
    is_warm
    is_casual
    is_animated
    is_random
    is_unstructured
  ].freeze

  QUESTIONS.each do |question|
    attribute question, :boolean
  end

  validates(*QUESTIONS, inclusion: { in: [true, false] })

  def score
    calculate_score(QUESTIONS)
  end
end
