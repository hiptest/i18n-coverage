require 'i18n/coverage/key_lister'

RSpec.describe I18n::Coverage::KeyLister do
  let(:subject) { I18n::Coverage::KeyLister }

  context '.list_keys' do
    it 'reads all keys in an English locale file' do
      expect(subject.list_keys(locale_dir_path: 'spec/fixtures/simple')).to contain_exactly('home.title', 'home.desc', 'error')
    end

    it 'reads all keys in a specified locale file' do
      expect(subject.list_keys(locale: 'es', locale_dir_path: 'spec/fixtures/simple')).to contain_exactly('other_key')
    end

    it 'reads all keys split across locale files' do
      expect(subject.list_keys(locale_dir_path: 'spec/fixtures/multiple')).to contain_exactly('home.title', 'home.desc', 'error')
    end

    it 'does not take into account the keys used for pluralization' do
      expect(subject.list_keys(locale_dir_path: 'spec/fixtures/plurals')).to contain_exactly('simple', 'pluralized')
    end
  end
end
