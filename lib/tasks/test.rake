# frozen_string_literal: true

namespace :test do
  desc 'Run the most recently edited test file'
  task wip: :environment do
    last_test_file = Dir.glob('test/**/*_test.rb').max_by { |f| File.mtime(f) }
    test_command = "rails test #{last_test_file}"
    puts test_command
    system(test_command)
  end

  desc 'Run tests for files changed from master branch'
  task diff: :environment do
    changed_files = `git diff --name-only master`.split("\n")
    test_files = changed_files.grep(/_test\.rb$/)

    changed_files.each do |file|
      if file.match(%r{app/models/(.+)\.rb})
        model_test_file = "test/models/#{Regexp.last_match(1)}_test.rb"
        test_files << model_test_file if File.exist?(model_test_file)
      elsif file.match(%r{app/controllers/(.+)_controller\.rb})
        controller_test_file = "test/controllers/#{Regexp.last_match(1)}_controller_test.rb"
        test_files << controller_test_file if File.exist?(controller_test_file)
      end
    end

    test_files.select! { |file| File.exist?(file) }

    test_files.uniq!
    test_command = "rails test #{test_files.join(' ')}"

    if test_files.empty?
      puts 'No relevant files changed from master branch.'
    else
      puts test_command
      system(test_command)
    end
  end
end
