# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.4.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
# gem 'rails', '~> 7.0.7', '>= 7.0.7.2'
gem "rails", "~> 7.1"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use the Puma web server [https://github.com/puma/puma]
# gem 'puma', '~> 5.6'
gem "puma", "~> 6.4"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'azure-storage-blob', '~> 2.0', require: false
gem 'interfaceable'
gem 'jbuilder'
gem 'responders'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false
gem 'simplecov', require: false
# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.2'
gem 'trix'

group :development, :test do
  gem 'byebug'
  gem 'rubocop-capybara', require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem 'spring'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'capybara-email', require: false
  gem 'minitest-stub_any_instance'
  gem 'minitest-stub-const'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'amazing_print'
gem 'devise', '~> 4.9'
gem 'devise_invitable'
gem 'tailwind_merge'

gem 'rubocop', '~> 1.57'
gem 'rubocop-rails', '~> 2.22'
gem 'rubocop-minitest', '~> 0.33.0'

gem 'pg', '~> 1.5'

gem 'shakapacker', '~> 7.1'

gem 'letter_opener', group: :development

gem 'simple_captcha2', require: 'simple_captcha'

gem 'ransack'

# Ruby 3.4 extracted stdlib gems
gem "mutex_m"
gem "observer"
gem "base64"
gem "drb"