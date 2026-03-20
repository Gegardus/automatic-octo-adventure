# frozen_string_literal: true

require 'tailwind_merge'

# Formbuilder for aligned platform, currently using tailwind
class AlignedFormBuilder < ActionView::Helpers::FormBuilder # rubocop:disable Metrics/ClassLength
  def check_box(attribute, options = {})
    @template.tag.div class: 'field flex items-center' do
      super(attribute, options_with_required(options, attribute).merge(
        class: 'h-4 w-4 text-dark-gray-600 border-gray-300 rounded focus:outline-none focus:ring-0'
      )) +
        label(attribute, options.merge(class: 'ml-2 text-sm text-silver-600 mb-0'))
    end
  end

  def email_field(attribute, options = {})
    @template.tag.div class: 'FormField mb-5' do
      label(attribute) +
        super(attribute, options_with_required(options, attribute).merge(class: default_input_class))
    end
  end

  def password_field(attribute, options = {})
    @template.tag.div class: 'FormField mb-5' do
      label(attribute, options) +
        super(attribute, options_with_required(options, attribute).merge(class: default_input_class))
    end
  end

  def text_field(attribute, options = {})
    @template.tag.div class: 'FormField mb-5' do
      label(attribute, options) +
        super(attribute, options_with_required(options, attribute).merge(class: default_input_class))
    end
  end

  def date_field(attribute, options = {})
    @template.tag.div class: 'FormField mb-5' do
      label(attribute, options) +
        super(attribute, options_with_required(options, attribute).merge(class: default_input_class))
    end
  end

  def select(attribute, choices = nil, options = {}, html_options = {}, &) # rubocop:disable Metrics/MethodLength
    select_class = 'block text-sm font-medium text-gray-900'
    klass = 'mt-1.5 w-full block rounded-lg border-gray-300 text-gray-700 sm:text-sm focus:border-[#333333]
            py-3 focus:ring-[#333333] focus:ring-1 focus:outline-none'
    label_options = html_options[:multiple] ? options : options.merge(class: select_class)

    if html_options[:multiple]
      html_options = html_options.merge(preline_multi_select_options)
    end

    merged_class = tw(options[:class], html_options[:class], klass)
    merged_html_options = html_options.merge(class: merged_class)

    @template.tag.div class: 'FormField mb-5' do
      label(attribute, label_options) +
        super(attribute, choices, options_with_required(
          options,
          attribute
        ), merged_html_options, &)
    end
  end

  def text_area(attribute, options = {})
    opts = options_with_required(options, attribute).merge(
      class: default_input_class,
      rows: (options[:rows] || 4)
    )
    @template.tag.div class: 'FormField mb-5' do
      label(attribute, options) +
        super(attribute, opts)
    end
  end

  def label(attribute, options = {})
    required = options_with_required(options, attribute).delete(:required)
    text = options[:label] || attribute.to_s.humanize
    label_text = required ? required_label_text(attribute, text) : text

    super(attribute, options.merge(class: merge_default_class(options, default_label_class))) do
      label_content = label_text
      label_content += tooltip_html(options[:note]) if options[:note]
      label_content
    end
  end

  def submit(label = nil, options = {})
    @template.tag.div class: 'flex justify-end' do
      super(label, options.reverse_merge(class: 'btn-primary mt-5'))
    end
  end

  def file_field(attribute, options = {})
    @template.tag.div class: 'FormField mb-5' do
      label(attribute, options.reverse_merge(class: 'mb-2')) +
        super(attribute, options_with_required(options, attribute).merge(
          class: merge_default_class(options, file_input_class)
        ))
    end
  end

  # rubocop:disable Metrics/ParameterLists, Metrics/AbcSize, Metrics/MethodLength
  def collection_radio_buttons(attribute, collection, value_method, text_method, options = {}, _html_options = {}, &)
    label_wrapper_class = 'flex p-3 w-full bg-white border border-gray-300 rounded-lg
     dark:bg-slate-900 dark:border-gray-700 items-center text-sm'

    @template.tag.div class: 'FormField mb-5' do
      @template.tag.p(class: merge_default_class(options, default_label_class)) do
        options[:label] || attribute.to_s.humanize
      end +
        @template.tag.div(class: 'grid grid-cols-1 gap-2 md:grid-cols-2 lg:gap-x-8') do
          radio_buttons = collection.each_with_object(''.html_safe) do |item, result|
            radio_value = item.send(value_method)
            radio_text = item.send(text_method)
            input_id = "#{attribute}_#{radio_value.to_s.parameterize}"

            result << @template.tag.label(for: input_id, class: label_wrapper_class) do
              radio_button(attribute, radio_value,
                           options.merge(
                             id: input_id,
                             class: tw(options[:class],
                                       ' focus:outline-none focus:ring-0 checked:bg-[#333333] text-[#333333] mt-0.5')
                           )) +
                @template.tag.span(radio_text, class: 'ml-2')
            end
          end
          radio_buttons
        end
    end
  end
  # rubocop:enable Metrics/ParameterLists, Metrics/AbcSize, Metrics/MethodLength

  private

  def options_with_required(options, attribute)
    options[:required] ||= attribute_required?(attribute)
    options
  end

  def tw(*classes)
    TailwindMerge::Merger.new.merge(classes.join(' '))
  end

  def merge_default_class(options, default_class)
    (options[:class] || '') + " #{default_class} "
  end

  def file_input_class
    'block max-w-full border border-gray-300 rounded-lg text-sm focus:z-10 focus:border-[#333333]
    focus:ring-[#333333] disabled:opacity-50 disabled:pointer-events-none dark:bg-slate-900 dark:border-gray-700
    dark:text-gray-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600 file:bg-gray-50 file:border-0
    file:bg-gray-100 file:me-4 file:py-3 file:px-4 dark:file:bg-gray-700 dark:file:text-gray-400 focus:ring-[#333333]'
  end

  def default_label_class
    'block text-sm font-medium leading-6 text-gray-900 text-base mb-4'
  end

  def default_input_class
    'block w-full rounded-md border-gray-300 py-3 text-gray-900 placeholder:text-gray-400 sm:text-sm
    focus:border-[#333333] focus:ring-[#333333] focus:ring-1 focus:outline-none disabled:opacity-50
    disabled:pointer-events-none'
  end

  def required_label_text(attribute, text)
    @template.content_tag(:span, text || attribute.to_s.humanize) +
      @template.content_tag(:span, '*', class: 'text-red-500')
  end

  # rubocop:disable Metrics/AbcSize
  def attribute_required?(attribute)
    return false if object.nil?

    return false unless object.class.try(:validators_on)

    object.class.validators_on(attribute).any? do |validator|
      next unless validator.is_a?(ActiveRecord::Validations::PresenceValidator)

      condition_met?(validator.options[:if]) || !condition_met?(validator.options[:unless])
    end
  end
  # rubocop:enable Metrics/AbcSize

  def condition_met?(condition)
    return true if condition.nil?

    condition.is_a?(Proc) ? object.instance_exec(&condition) : object.send(condition)
  end

  # rubocop:disable Layout/LineLength
  def preline_multi_select_options
    {
      'data-hs-select': {
        placeholder: 'Select multiple options...',
        toggleTag: "<button type='button'></button>",
        toggleClasses: 'hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50 relative py-3 px-4 pe-9 flex text-nowrap w-full cursor-pointer bg-white border border-gray-300 rounded-lg text-start text-sm before:absolute before:inset-0 before:z-[1] dark:bg-slate-900 dark:border-gray-700 dark:text-gray-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600 py-3 focus:ring-[#333333] focus:ring-2 focus:outline-none',
        dropdownClasses: 'mt-2 z-50 w-full max-h-[300px] p-1 space-y-0.5 bg-white border border-gray-300 rounded-lg overflow-hidden overflow-y-auto dark:bg-slate-900 dark:border-gray-700',
        optionClasses: 'py-2 px-4 w-full text-sm text-gray-800 cursor-pointer hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100 dark:bg-slate-900 dark:hover:bg-slate-800 dark:text-gray-200 dark:focus:bg-slate-800',
        optionTemplate: "<div class='flex justify-between items-center w-full'><span data-title></span><span class='hidden hs-selected:block'><svg class='flex-shrink-0 w-3.5 h-3.5 text-[#333333]' xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><polyline points='20 6 9 17 4 12'/></svg></span></div>"
      }.to_json
    }
  end
  # rubocop:enable Layout/LineLength

  # TODO: remove nocov once we add an input with a tooltip
  # :nocov:
  # rubocop:disable Layout/LineLength
  def tooltip_html(note) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    return unless note

    @template.content_tag(:div, class: 'ml-2 col-start-1 text-end inline-block align-middle justify-between') do
      @template.content_tag(:div, class: 'hs-tooltip inline-block [--placement:top]') do
        @template.content_tag(:button, type: 'button',
                                       class: 'hs-tooltip-toggle size-10 inline-flex justify-center items-center gap-2 rounded-full bg-gray-50 border border-gray-200 text-gray-600 hover:bg-blue-50 hover:border-blue-200 hover:text-blue-600 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-white/[.05] dark:hover:border-white/[.1] dark:hover:text-white') do
          @template.tag.svg(class: 'flex-shrink-0 size-4', xmlns: 'http://www.w3.org/2000/svg', width: '18',
                            height: '18', viewBox: '0 0 24 24') do
            @template.tag.defs do
              @template.tag.style('.a{fill:none;stroke:currentColor;stroke-linecap:round;stroke-linejoin:round;}')
            end +
              @template.tag.title('question-circle') +
              @template.tag.path(class: 'a',
                                 d: 'M12,17a.25.25,0,1,0,.25.25A.25.25,0,0,0,12,17h0') +
              @template.tag.path(class: 'a',
                                 d: 'M9,10.005a3,3,0,1,1,4.2,2.75A2,2,0,0,0,12,14.588V15')
          end +
            @template.content_tag(:span, note,
                                  class: 'hs-tooltip-content hs-tooltip-shown:opacity-100 hs-tooltip-shown:visible opacity-0 transition-opacity inline-block absolute invisible z-10 py-1 px-2 bg-gray-900 text-xs font-medium text-white rounded shadow-sm dark:bg-slate-700', role: 'tooltip')
        end
      end
    end
    # rubocop:enable Layout/LineLength
    # :nocov:
  end
end
