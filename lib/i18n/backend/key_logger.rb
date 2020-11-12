require 'i18n/coverage/key_logger'

module I18n
  module Backend
    module KeyLogger
      def lookup(locale, key, scope = [], options = {})
        full_key = (Array(scope || []) + [key]).compact.join('.')
        I18n::Coverage::KeyLogger.store_key(full_key)
        super
      end
    end
  end
end
