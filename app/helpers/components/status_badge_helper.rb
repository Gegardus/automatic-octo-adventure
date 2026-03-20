# frozen_string_literal: true

module Components
  module StatusBadgeHelper
    def render_status_badge(label:, type:, **options)
      combined_classes = "#{shared_classes} #{class_for_type(type)} #{options[:class]}".strip
      content_tag(:span, label, class: combined_classes)
    end

    private

    def shared_classes
      'inline-flex items-center gap-x-2.5 py-1.5 px-3 rounded-full text-xs font-medium'
    end

    # :nocov:
    def class_for_type(type)
      case type # rubocop:disable Style/HashLikeCase:
      when :success
        'bg-teal-100 text-teal-800 dark:bg-teal-800/30 dark:text-teal-500'
      when :warning
        'bg-orange-100 text-orange-800 dark:bg-orange-800/30 dark:text-orange-500'
      when :danger
        'bg-red-100 text-red-800 dark:bg-red-800/30 dark:text-red-500'
      end
    end
    # :nocov:
  end
end
