require 'i18n'

RSpec.describe I18n::Backend::KeyLogger do
  let(:key_logger) { I18n::Coverage::KeyLogger }

  before do
    # Ok, that could be better with mocking/dummy classes but at least it tests in real conditions
    I18n::Backend::Simple.include described_class
    I18n.backend.store_translations(:en, some_key: 'Some key in :en')
    I18n.backend.store_translations(:en, some_outer_prefix: { some_prefix: { some_key: 'Scoped translation' } })
  end

  it 'stores the keys used when translating in a I18n::Coverage::KeyLogger' do
    I18n.translate('some_key')
    expect(key_logger.stored_keys).to include('some_key')
  end

  it 'does not impact the translation process' do
    expect(I18n.translate('some_key')).to eq('Some key in :en')
    expect(I18n.translate('some_key', scope: %i[some_outer_prefix some_prefix])).to eq('Scoped translation')
  end

  it 'stores keys used with an optional scope argument' do
    I18n.translate('some_key', scope: %i[some_outer_prefix some_prefix])
    expect(key_logger.stored_keys).to include('some_outer_prefix.some_prefix.some_key')
  end

  it 'stores keys these are looked up but are not strictly translated' do
    I18n.exists?('some_key')
    expect(key_logger.stored_keys).to include('some_key')
  end
end
