require "i18n"
require "bundler/setup"
require "i18n/coverage"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    require 'i18n/coverage/key_logger'
    I18n::Coverage::KeyLogger.clear_keys
  end
end
