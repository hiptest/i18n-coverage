module I18n
  module Coverage
    module Printers
      class FilePrinter
        REPORT_PATH = 'coverage/i18n.json'.freeze

        def self.print(report)
          new(report).print
        end

        def initialize(report)
          @report = report
        end

        def print
          write_report
          print_message
        end

        def write_report
          FileUtils.mkdir_p(File.dirname(REPORT_PATH))
          File.write(REPORT_PATH, JSON.pretty_generate(@report))
        end

        def print_message
          puts "Coverage report generated for I18n to #{REPORT_PATH}. " \
            "#{@report[:used_key_count]} / #{@report[:key_count]} keys " \
            "(#{@report[:percentage_used].round(2)}%) covered."
        end
      end
    end
  end
end
