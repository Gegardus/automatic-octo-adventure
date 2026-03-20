# frozen_string_literal: true

module Components
  module CenteredContentHelper
    def render_centered_content(heading:, &)
      render('components/ui/centered_content', heading: heading, &)
    end
  end
end
