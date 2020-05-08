RSpec.describe I18n::Coverage::Printers::BasicPrinter do
  describe '.print' do
    it 'outputs a summary of the I18n keys used during tests' do
      hash_report = {
        key_count: 4,
        used_key_count: 2,
        percentage_used: 50.0,
        unused_keys: ["a", "b"]
      }

      expect { described_class.print(hash_report) }.to output([
        '',
        'I18n Coverage: 50.0% of the keys used',
        '4 keys found in yml files, 2 keys used during the tests',
        'Unused keys:',
        '  a',
        '  b',
        ''
      ].join("\n")).to_stdout
    end
  end
end
