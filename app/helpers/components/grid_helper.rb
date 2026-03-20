# frozen_string_literal: true

module Components
  module GridHelper
    def render_grid(columns: :two, **options, &block)
      classes = options[:class]
      render('components/ui/grid', columns:, classes: classes || '', &block)
    end
  end
end
