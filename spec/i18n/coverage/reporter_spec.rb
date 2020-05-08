require 'i18n/coverage/reporter'

RSpec.describe I18n::Coverage::Reporter do
  let(:subject) { I18n::Coverage::Reporter }

  context '.report' do
    it 'outputs a summary of the I18n keys used during tests' do
      expect { subject.report }.to output([
        '',
        'I18n Coverage: 0.0% of the keys used',
        '3 keys found in yml file, 0 keys used during the tests',
        'Unused keys:',
        '  home.title',
        '  home.desc',
        '  error',
        ''
      ].join("\n")).to_stdout
    end
  end

  context '#hash_report' do
    it 'provides the same data as .report but in a machine-readable way' do
      report = subject.new.hash_report

      expect(report[:key_count]).to eq(3)
      expect(report[:used_key_count]).to eq(0)
      expect(report[:percentage_used]).to eq(0)
      expect(report[:unused_keys]).to contain_exactly('home.title', 'home.desc', 'error')
    end

    it 'supports advanced I18n calls with prefixes' do
      I18n::Coverage::KeyLogger.store_key('home')
      report = subject.new.hash_report

      expect(report[:key_count]).to eq(3)
      expect(report[:used_key_count]).to eq(2)
      expect(report[:percentage_used]).to eq(2/3.to_f * 100)
      expect(report[:unused_keys]).to contain_exactly('error')
    end
  end
end
