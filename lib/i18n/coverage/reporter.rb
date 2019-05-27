require 'i18n/coverage/key_lister'
require 'i18n/coverage/key_logger'

module I18n
  module Coverage
    class Reporter
      def self.report(locale: 'en', locale_dir_path: 'config/locales')
        Reporter.new(locale: locale, locale_dir_path: locale_dir_path).report
      end

      def initialize(locale: 'en', locale_dir_path: 'config/locales')
        @existing_keys = KeyLister.list_keys(locale: locale, locale_dir_path: locale_dir_path)
        @used_keys = KeyLogger.stored_keys
        @percentage_used = (@used_keys.count.to_f / @existing_keys.count.to_f) * 100
        @unused_keys = @existing_keys - @used_keys
      end

      def report
        puts ""
        puts "I18n Coverage: #{@percentage_used.round(2)}% of the keys used"
        puts "#{@existing_keys.count} keys found in yml file, #{@used_keys.count} keys used during the tests"

        if @unused_keys
          puts "Unused keys:"
          @unused_keys.map {|k| puts "  #{k}"}
        end
      end

      def hash_report
        {
          key_count: @existing_keys.count,
          used_key_count: @used_keys.count,
          percentage_used: @percentage_used,
          unused_keys: @unused_keys
        }
      end
    end
  end
end