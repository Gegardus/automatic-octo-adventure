# frozen_string_literal: true

module Components
  module AccordionHelper
    # rubocop:disable Metrics/BlockLength, Metrics/AbcSize, Metrics/MethodLength, Rails/OutputSafety, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def render_accordion(accordion_items)
      content_tag(:div, class: 'hs-accordion-group') do
        accordion_items.map.with_index do |item, index|
          title = item[:title]
          content = item[:content]
          active = item[:active] ? 'active' : ''

          content_tag(
            :div,
            class: "hs-accordion #{active} bg-white border -mt-px first:rounded-t-lg
                    last:rounded-b-lg dark:bg-gray-800 dark:border-gray-700",
            id: "hs-bordered-heading-#{index}"
          ) do
            concat(
              content_tag(
                :button,
                class: 'hs-accordion-toggle hs-accordion-active:text-green-600 inline-flex items-center gap-x-3 w-full
                  font-semibold text-start text-gray-800 py-4 px-5 hover:text-gray-500 disabled:opacity-50
                  disabled:pointer-events-none dark:hs-accordion-active:text-green-500 dark:text-gray-200
                  dark:hover:text-gray-400 dark:focus:outline-none dark:focus:text-gray-400',
                'aria-controls': "hs-basic-bordered-collapse-#{index}",
                disabled: !item[:active] && !item[:completed] && !item[:completed].nil? &&
                          !Rails.env.development? && !Rails.env.staging?
              ) do
                concat(
                  content_tag(
                    :svg,
                    class: 'hs-accordion-active:hidden block w-4 h-4',
                    xmlns: 'http://www.w3.org/2000/svg',
                    fill: 'none',
                    viewBox: '0 0 24 24',
                    stroke: 'currentColor'
                  ) do
                    tag.path(d: 'M5 12h14') + tag.path(d: 'M12 5v14')
                  end
                )
                concat(
                  content_tag(
                    :svg,
                    class: 'hs-accordion-active:block hidden w-4 h-4',
                    xmlns: 'http://www.w3.org/2000/svg',
                    fill: 'none',
                    viewBox: '0 0 24 24',
                    stroke: 'currentColor'
                  ) do
                    tag.path(d: 'M5 12h14')
                  end
                )
                concat(title)
                if item[:status]
                  concat(item[:status])
                end
              end
            )
            concat(
              content_tag(
                :div,
                id: "hs-basic-bordered-collapse-#{index}",
                class: "hs-accordion-content #{item[:active] ? '' : 'hidden'} w-full overflow-hidden
                  transition-[height] duration-300", 'aria-labelledby': "hs-bordered-heading-#{index}"
              ) do
                content_tag(:div, class: 'pb-4 px-5') do
                  content_tag(:p, content, class: 'text-gray-800 dark:text-gray-200')
                end
              end
            )
          end
        end.join.html_safe
      end
    end
    # rubocop:enable Metrics/BlockLength, Metrics/AbcSize, Metrics/MethodLength, Rails/OutputSafety, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  end
end
