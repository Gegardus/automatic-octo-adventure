# frozen_string_literal: true

module Components
  module OrderedListHelper
    def render_ordered_list(items:)
      render('components/ui/ordered_list', items: items)
    end
  end
end
