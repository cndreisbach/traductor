module I18n
  module Backend
    class SnippetBackend < Simple
      protected

      def init_translations
        load_translations(*I18n.load_path.flatten)
        load_translations_from_database
        @initialized = true
      end

      def load_translations_from_database
        data = { :en => {}, :es => {} }

        Snippet.all.each do |snippet|
          path = snippet.name.split(".")
          key = path.pop

          en = data[:en]
          es = data[:es]

          path.each do |group|
            en[group] ||= {}
            en = en[group]

            es[group] ||= {}
            es = es[group]
          end

          en[key] = snippet.english
          es[key] = snippet.spanish
        end

        data.each { |locale, d| merge_translations(locale, d) }
      end
    end
  end
end
