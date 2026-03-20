# frozen_string_literal: true

# class to track users steps through the immigration pages
class ImmigrationModule < ApplicationRecord
  belongs_to :current_immigration_quiz, optional: true, class_name: 'ImmigrationQuiz'
  has_many :immigration_quizzes, dependent: :destroy

  delegate :passed?, to: :current_immigration_quiz, allow_nil: true
end
