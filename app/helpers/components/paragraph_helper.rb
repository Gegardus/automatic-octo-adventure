# frozen_string_literal: true

module Components
  module ParagraphHelper
    def render_paragraph(content:)
      render('components/ui/paragraph', content: content)
    end
  end
end
