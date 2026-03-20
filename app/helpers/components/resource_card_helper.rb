# frozen_string_literal: true

module Components
  module ResourceCardHelper
    def render_resource_card(title:, content:)
      render('components/ui/resource_card', title: title, content: content)
    end
  end
end
