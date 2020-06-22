require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

require 'i18n'
require 'bundler/setup'
require 'i18n/coverage'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before do
    I18n::Coverage::KeyLogger.clear_keys

    I18n::Coverage.configure do |cov_config|
      cov_config.locale_dir_path = 'spec/fixtures/simple'
    end
  end
end
