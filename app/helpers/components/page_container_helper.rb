# frozen_string_literal: true

module Components
  module PageContainerHelper
    def render_page_container(&)
      render('components/ui/page_container', &)
    end
  end
end
