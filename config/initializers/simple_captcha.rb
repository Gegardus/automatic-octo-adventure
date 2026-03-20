# frozen_string_literal: true

SimpleCaptcha.setup do |sc|
  sc.font = 'DejaVu-Sans' unless Rails.env.development?
end
