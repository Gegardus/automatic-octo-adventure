# frozen_string_literal: true

module Components
  module TitleHelper
    def render_title(title:, size:, id: nil)
      render('components/ui/title', title: title, size: size, id: id)
    end
  end
end
