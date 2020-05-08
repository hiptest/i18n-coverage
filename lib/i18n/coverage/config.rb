module I18n
  module Coverage
    class Config
      attr_accessor :locale,
                    :locale_dir_path

      def initialize
        self.locale = "en"
        self.locale_dir_path = "config/locales"
      end
    end
  end
end
