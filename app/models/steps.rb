# frozen_string_literal: true

# collection of models that implement Step
class Steps
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :all_steps, array: true
  attribute :current_step
  attribute :title

  def all_steps=(steps)
    super
    self.current_step ||= current_available_step
  end

  def completed?
    all_steps.all?(&:completed?)
  end

  def next_step
    all_steps.find { |step| step.step_name == current_step.next_step_name }
  end

  def previous_step
    step_for_step_name(current_step.previous_step_name)
  end

  def next_step_available?
    all_steps[0..all_steps.index(current_step)].all?(&:completed?)
  end

  def step_for_step_name(step_name)
    all_steps.find { |step| step.step_name == step_name }
  end

  def current_available_step
    all_steps.find { |step| !step.completed? && !step.skipped? }
  end
end
