# frozen_string_literal: true

module Components
  module TableHelper
    def render_table(collection, **options, &) # rubocop:disable Metrics/MethodLength
      class_humanized_name = collection.class.to_s.split('::')[0].titleize.downcase

      content_tag :div, class: 'overflow-x-auto' do
        content_tag :table, options.merge(
          class: tw('min-w-full text-sm border-b', options[:class])
        ) do
          if collection.any?
            capture(&)
          else
            render_alert(variant: :info, title: 'Info',
                         description: "No #{class_humanized_name.pluralize}.")
          end
        end
      end
    end

    def table_head(**options, &)
      content_tag :thead, options.merge(
        class: tw('[&_tr]:border-b', options[:class])
      ) do
        content_tag :tr, class: 'border-b transition-colors hover:bg-muted/50 data-[state=selected]:bg-muted' do
          capture(&)
        end
      end
    end

    def table_header(content = nil, **options)
      content_tag :th, options.merge(
        class: tw('h-12 px-4 text-left align-middle font-medium text-muted-foreground [&:has([role=checkbox])]:pr-0',
                  options[:class])
      ) do
        content
      end
    end

    def table_body(**options, &)
      content_tag(:tbody, class: options.merge(
        class: tw('[&_tr:last-child]:border-0', options[:class])
      ), &)
    end

    def table_row(**options, &)
      content_tag(:tr, options.merge(
                         class: tw('border-b transition-colors hover:bg-muted/50 data-[state=selected]:bg-muted',
                                   options[:class])
                       ), &)
    end

    def table_column(_content = nil, **options, &)
      content_tag :td, options.merge(
        class: tw('p-4 align-middle [&:has([role=checkbox])]:pr-0', options[:class])
      ) do
        capture(&)
      end
    end
  end
end
