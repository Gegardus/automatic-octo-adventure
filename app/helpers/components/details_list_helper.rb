# frozen_string_literal: true

module Components
  module DetailsListHelper
    def render_details_list(list:, class_names: '')
      render('components/ui/details_list', list: list, class_names: class_names)
    end
  end
end
