module I18n
  module Coverage
    class KeyLogger
      def self.store_key(key)
        KeyLogger.new.store_key(key)
      end

      def self.stored_keys
        KeyLogger.new.stored_keys
      end

      def self.clear_keys
        KeyLogger.new.clear_keys
      end

      def store_key(key)
        stored_keys.add(key)
      end

      def clear_keys
        stored_keys.clear        
      end

      def stored_keys
        @@stored_keys ||= Set[]
      end
    end
  end
end
