require 'i18n/coverage/key_logger'

module I18n
  module Backend
    module KeyLogger
      def translate(*args)
        I18n::Coverage::KeyLogger.store_key(args[1])
        super
      end
    end
  end
end
