RSpec.describe I18n::Coverage do
  it "has a version number" do
    expect(I18n::Coverage::VERSION).not_to be nil
  end

  describe ".start" do
    it "instruments I18n and prints a report at exit" do
      expect(I18n::Backend::Simple).to receive(:include).with(I18n::Backend::KeyLogger)
      expect(subject).to receive(:at_exit)
      subject.start
    end
  end
end
