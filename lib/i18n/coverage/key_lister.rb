require 'yaml'

module I18n
  module Coverage
    class KeyLister
      def self.list_keys
        KeyLister.new.list_keys
      end

      def initialize
        locale_dir_path = I18n::Coverage.config.locale_dir_path
        @locale_files = Dir.glob("#{locale_dir_path}/**/*.yml")
        @keys = Set[]
      end

      def list_keys
        @locale_files
          .map(&YAML.method(:load_file))
          .flat_map { |hash| visit_childs(source: hash, path: []) }

        @keys
      end

      private

      def visit_childs(source:, path: )
        node = source.dig(locale, *path)

        if node.respond_to? :keys
          keys = node.keys

          if pluralization_keys?(keys)
            @keys.add(path.join('.'))
          else
            keys.map {|key| visit_childs(source: source, path: path + [key])}
          end
        elsif path.count > 0
          @keys.add(path.join('.'))
        end
      end

      def pluralization_keys?(keys)
        return (keys - ['zero', 'one', 'other']).empty?
      end

      def locale
        I18n::Coverage.config.locale
      end
    end
  end
end
