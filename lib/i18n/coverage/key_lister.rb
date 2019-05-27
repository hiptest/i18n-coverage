require 'yaml'

module I18n
  module Coverage
    class KeyLister
      def self.list_keys(locale: 'en', locale_dir_path: 'config/locales')
        KeyLister.new(locale, locale_dir_path).list_keys
      end
  
      def initialize(locale, locale_dir_path)
        @locale = locale
        @source = YAML.load(File.open(File.expand_path("#{locale_dir_path}/#{locale}.yml")))
        @keys = Set[]
      end
  
      def list_keys
        visit_childs(path: [])
        @keys
      end
  
      private
  
      def visit_childs(path: )
        node = @source.dig(*[@locale, path].flatten.compact)
        if node.respond_to? :keys
          keys = node.keys

          if pluralization_keys?(keys)
            @keys.add(path.join('.'))
          else
            keys.map {|key| visit_childs(path: [path, key].flatten.compact)}
          end
        else
          @keys.add(path.join('.'))
        end
      end

      def pluralization_keys?(keys)
        return (keys - ['zero', 'one', 'other']).empty?
      end
    end
  end
end
