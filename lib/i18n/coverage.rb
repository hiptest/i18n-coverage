require "i18n"
require "i18n/coverage/version"
require "i18n/coverage/reporter"
require "i18n/backend/key_logger"

module I18n
  module Coverage
  end
end

I18n::Backend::Simple.send(:include, I18n::Backend::KeyLogger) if ENV['I18N_COVERAGE']
