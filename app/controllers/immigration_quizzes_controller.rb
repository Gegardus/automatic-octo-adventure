# frozen_string_literal: true

class ImmigrationQuizzesController < ApplicationController
  authorized_when { current_user.applicant? }

  include StepsForImmigration

  before_action -> { setup_immigration_for_step(:final_quiz) }

  def new
    @immigration_quiz = current_user.immigration_module.build_current_immigration_quiz
  end

  def create
    immigration_module = current_user.immigration_module

    @immigration_quiz = ImmigrationQuiz.new(immigration_quiz_params.merge(immigration_module: immigration_module))

    immigration_module&.update!(current_immigration_quiz: @immigration_quiz)

    if @immigration_quiz.passed?
      redirect_to modules_path, notice: 'Final quiz passed!'
    else
      redirect_to new_immigration_quizzes_path,
                  alert: 'Final quiz failed, at least 8 questions must be answered correctly. Please try again'
    end
  end

  private

  def immigration_quiz_params
    params.require(:immigration_quiz).permit(*ImmigrationQuiz::QUESTIONS)
  end
end
