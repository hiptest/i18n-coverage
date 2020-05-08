require 'i18n/coverage/printers/file_printer'

RSpec.describe I18n::Coverage::Printers::FilePrinter do
  describe '.print' do
    let(:hash_report) do
      {
        key_count: 4,
        used_key_count: 2,
        percentage_used: 50.0,
        unused_keys: %w[a b]
      }
    end

    before do
      allow(FileUtils).to receive(:mkdir_p)
      allow(File).to receive(:write)
    end

    it 'outputs a SimpleCov-style summary of I18n coverage' do
      expect { described_class.print(hash_report) }.to output(
        "Coverage report generated for I18n to coverage/i18n.json. 2 / 4 keys (50.0%) covered.\n"
      ).to_stdout
    end

    it 'writes the coverage report to a JSON file' do
      expect(FileUtils).to receive(:mkdir_p).with(
        File.dirname(I18n::Coverage::Printers::FilePrinter::REPORT_PATH)
      )

      expect(File).to receive(:write).with(
        I18n::Coverage::Printers::FilePrinter::REPORT_PATH,
        JSON.pretty_generate(hash_report)
      )

      described_class.print(hash_report)
    end
  end
end
