# frozen_string_literal: true

module Components
  module PageHeaderHelper
    def render_page_header(heading:, header_classes: '', &)
      render('components/ui/page_header', heading: heading, header_classes: header_classes, &)
    end
  end
end
