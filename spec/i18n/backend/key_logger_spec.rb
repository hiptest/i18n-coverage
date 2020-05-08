require 'i18n'

RSpec.describe I18n::Backend::KeyLogger do
  let(:key_logger) { I18n::Coverage::KeyLogger }

  before do
    # Ok, that could be better with mocking/dummy classes but at least it tests in real conditions
    I18n::Backend::Simple.include described_class
    I18n.backend.store_translations(:en, some_key: 'Some key in :en')
  end

  it 'stores the keys used when translating in a I18n::Coverage::KeyLogger' do
    I18n.translate('some_key')
    expect(key_logger.stored_keys).to include('some_key')
  end

  it 'does not impact the translation process' do
    expect(I18n.translate('some_key')).to eq('Some key in :en')
  end
end
