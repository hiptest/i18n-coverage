require 'i18n/coverage/key_logger'

RSpec.describe I18n::Coverage::KeyLogger do
  let(:subject) { described_class }

  it 'stores keys with "store_key" and provides the ones stored with "stored_keys"' do
    subject.store_key('Ho hi :)')

    expect(subject.stored_keys).to contain_exactly('Ho hi :)')
  end

  it 'does not duplicate keys' do
    subject.store_key('Ho hi :)')
    subject.store_key('Ho hi :)')

    expect(subject.stored_keys.length).to eq(1)
  end

  describe '.clear_keys' do
    it 'empties the stored keys' do
      subject.store_key('plop')
      subject.clear_keys

      expect(subject.stored_keys).to be_empty
    end
  end
end
