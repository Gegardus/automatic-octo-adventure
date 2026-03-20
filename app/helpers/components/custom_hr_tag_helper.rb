# frozen_string_literal: true

module Components
  module CustomHrTagHelper
    def custom_hr_tag
      content_tag(:hr, '', class: 'h-px my-8 bg-gray-200 border-0 dark:bg-gray-700')
    end
  end
end
