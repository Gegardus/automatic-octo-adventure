# frozen_string_literal: true

module Components
  module StepsHelper
    def render_steps(steps:, current_step:, step_links: [], disabled: false)
      render(
        'components/ui/steps', steps: steps, current_step: current_step, step_links: step_links, disabled: disabled
      )
    end
  end
end
