# frozen_string_literal: true

coverage_mode = ENV['COVERAGE']

if coverage_mode
  require 'simplecov'

  SimpleCov.start 'rails' do
    formatter SimpleCov::Formatter::MultiFormatter.new(
      [
        SimpleCov::Formatter::SimpleFormatter,
        SimpleCov::Formatter::HTMLFormatter
      ]
    )

    add_filter 'app/lib/'
    add_filter 'lib/rails/generators/'
    add_filter 'app/channels'
    add_filter 'app/mailers'
    add_filter 'app/jobs/application_job.rb'
    add_filter 'lib/rubo_cop'

    case coverage_mode
    when 'models'
      add_filter 'app/controllers/'
      add_filter 'app/components/'
      add_filter 'app/helpers/'
      add_filter 'app/lib'
      add_filter 'lib/application_responder'
    when 'controllers'
      add_filter 'app/models/'
    end
  end

  SimpleCov.minimum_coverage line: 100
end
