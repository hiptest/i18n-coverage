module I18n
  module Coverage
    class KeyLogger
      def self.store_key(key)
        stored_keys.add(key)
      end

      def self.stored_keys
        @stored_keys ||= Set[]
      end

      def self.clear_keys
        stored_keys.clear
      end
    end
  end
end
