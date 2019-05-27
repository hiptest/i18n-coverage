require 'i18n/coverage/key_lister'

RSpec.describe I18n::Coverage::KeyLister do
  let(:subject) { I18n::Coverage::KeyLister }

  context '.list_keys' do
    it 'reads all keys from a locale file' do
      expect(subject.list_keys(locale_dir_path: 'spec/fixtures/simple')).to contain_exactly('home.title', 'home.desc', 'error')
    end
   
    it 'uses by default "config/locales/en.yml"' do
      allow(File).to receive(:open).and_return("---\nen:\n  test: '1'")

      subject.list_keys
      expect(File).to have_received(:open).with(File.expand_path('config/locales/en.yml'))
    end

    it 'does not take into account the keys used for pluralization' do
      expect(subject.list_keys(locale_dir_path: 'spec/fixtures/plurals')).to contain_exactly('simple', 'pluralized')
    end
  end
end