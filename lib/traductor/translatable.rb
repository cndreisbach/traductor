module Traductor  
  module Translatable
    def self.included(base)
      base.module_eval do
        extend ClassMethods      
        # has_many :translations, :class_name => 'Traductor::Translation', :as => :source
      end
    end
    
    def get_translation(locale)
      self.translations.find_by_locale(locale) || self.translations.build(:locale => locale)
    end
    
    def get_translation_for(field, locale)
      tr = get_translation(locale)
      tr[field] || read_attribute(field)
    end
    
    def set_translation_for(field, locale, val)
      tr = get_translation(locale)
      tr[field] = val
      tr.save
    end
    
    module ClassMethods
      def translated_fields(*fields)
        fields.each do |field|
          self.module_eval %Q{
            def #{field}
              if I18n.default?
                read_attribute(#{field.inspect})
              else
                get_translation_for(#{field.inspect}, I18n.locale) 
              end
            end
            
            def #{field}=(val)
              if I18n.default?
                write_attribute(#{field.inspect}, val)
              else
                set_translation_for(#{field.inspect}, I18n.locale, val)
              end
            end            
          }
        end        
      end
    end
  end
end