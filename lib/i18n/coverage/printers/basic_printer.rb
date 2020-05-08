module I18n
  module Coverage
    module Printers
      class BasicPrinter
        def self.print(report)
          new(report).print
        end

        def initialize(report)
          @report = report
        end

        def print
          puts ""
          puts "I18n Coverage: #{@report[:percentage_used].round(2)}% of the keys used"
          puts "#{@report[:key_count]} keys found in yml files, #{@report[:used_key_count]} keys used during the tests"

          if @report[:unused_keys]
            puts "Unused keys:"
            @report[:unused_keys].map {|k| puts "  #{k}"}
          end
        end
      end
    end
  end
end
