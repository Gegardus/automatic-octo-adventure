# frozen_string_literal: true

# All step classes must implement these methods
module Step
  def completed?; end

  def step_name; end

  def next_step_name; end

  def previous_step_name; end
end
