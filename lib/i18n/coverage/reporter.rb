require 'i18n/coverage/key_lister'
require 'i18n/coverage/key_logger'

module I18n
  module Coverage
    class Reporter
      def self.report
        Reporter.new.report
      end

      def initialize
        @existing_keys = KeyLister.list_keys
        @stored_keys = KeyLogger.stored_keys
      end

      def report
        puts ""
        puts "I18n Coverage: #{hash_report[:percentage_used].round(2)}% of the keys used"
        puts "#{hash_report[:key_count]} keys found in yml file, #{hash_report[:used_key_count]} keys used during the tests"

        if hash_report[:unused_keys]
          puts "Unused keys:"
          hash_report[:unused_keys].map {|k| puts "  #{k}"}
        end
      end

      def hash_report
        used_keys = @existing_keys - unused_keys
        percentage_used = (used_keys.count.to_f / @existing_keys.count) * 100

        {
          key_count: @existing_keys.count,
          used_key_count: used_keys.count,
          percentage_used: percentage_used,
          unused_keys: unused_keys.to_a
        }
      end

      private

      def unused_keys
        @unused_keys ||= @existing_keys.reject do |key|
          @stored_keys.any? { |stored_key| key.start_with?(stored_key.to_s) }
        end
      end
    end
  end
end
