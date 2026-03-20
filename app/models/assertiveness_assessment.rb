# frozen_string_literal: true

# Estimates applicant assertiveness
class AssertivenessAssessment < ApplicationRecord
  include BooleanScore

  QUESTIONS = %i[
    is_competitive
    is_decisive
    is_to_the_point
    is_impatient
    is_bold
    is_confronting
    is_challenging
    is_forthright
    is_fast_paced
    is_outspoken
  ].freeze

  QUESTIONS.each do |question|
    attribute question, :boolean
  end

  validates(*QUESTIONS, inclusion: { in: [true, false] })

  def score
    calculate_score(QUESTIONS)
  end
end
