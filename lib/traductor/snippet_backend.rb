module Traductor
  class SnippetBackend < I18n::Backend::Simple
    # These are the only supported locales
    LOCALES = [:en, :es] 
  
    protected

    def init_translations
      load_translations(*I18n.load_path.flatten)
      load_translations_from_database
      @initialized = true
    end

    def load_translations_from_database
      data = { }
      LOCALES.each { |locale| data[locale] = {} }

      Snippet.all.each do |snippet|
        path = snippet.name.split(".")
        key = path.pop

        current = {}
        LOCALES.each { |locale| current[locale] = data[locale] }

        path.each do |group|
          LOCALES.each do |locale| 
            current[locale][group] ||= {}
            current[locale] = current[locale][group]
          end
        end

        LOCALES.each { |locale| current[locale][key] = snippet.read_attribute("#{locale}_text") }        
      end
      data.each { |locale, d| merge_translations(locale, d) }
    end
  end
end
