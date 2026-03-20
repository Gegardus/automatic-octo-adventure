# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AlignedSuv
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller
    config.load_defaults 7.0
    config.active_storage.variant_processor = :mini_magick
    config.action_controller.action_on_unpermitted_parameters = :raise
    Rails::Html::WhiteListSanitizer.allowed_tags << 'iframe'

    config.generators do |g|
      g.jbuilder false
      g.helper false

      g.scaffold_controller = :scaffold_controller
    end
  end
end
