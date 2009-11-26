module Traductor
  class GoogleBackend < I18n::Backend::Simple
    def translate(locale, key, options = {})
      if locale.to_s == 'en'
        key
      else
        Translate.t(key, 'en', locale.to_s)
      end
    end
    
    protected

    def init_translations
      @initialized = true
    end
  end
end
