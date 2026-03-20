# frozen_string_literal: true

module Components
  module UnorderedListHelper
    def render_unordered_list(items:)
      render('components/ui/unordered_list', items: items)
    end
  end
end
