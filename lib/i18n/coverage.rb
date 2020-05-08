require "i18n"
require "i18n/coverage/version"
require "i18n/coverage/reporter"
require "i18n/backend/key_logger"

module I18n
  module Coverage
    def self.start
      I18n::Backend::Simple.send(:include, I18n::Backend::KeyLogger)
      at_exit { I18n::Coverage::Reporter.report }
    end
  end
end

if ENV['I18N_COVERAGE']
  warn "DEPRECATED: use I18n::Coverage.start instead"
  I18n::Backend::Simple.send(:include, I18n::Backend::KeyLogger)
end
