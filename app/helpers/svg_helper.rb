# frozen_string_literal: true

module SvgHelper
  def render_svg(filename, options = {})
    file_path = Rails.root.join('app', 'javascript', 'images', 'icons', "#{filename}.svg")
    file = file_path.read
    svg = Nokogiri::HTML::DocumentFragment.parse(file)
    svg['class'] = options[:class] if options[:class].present?
    raw svg # rubocop:disable Rails/OutputSafety
  end
end
