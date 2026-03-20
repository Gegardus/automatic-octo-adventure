# frozen_string_literal: true

# A resource for the platform steps with rich text content
class Resource < ApplicationRecord
  has_rich_text :content

  validates :name, :content, presence: true

  RESOURCE_MODULES = (%w[general] + ApplicationModules::MODULES).map(&:to_s).freeze

  enum application_module: RESOURCE_MODULES.to_h { |type| [type, type] }, _default: 'general'
end
