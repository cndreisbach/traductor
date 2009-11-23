module Traductor  
  module Translatable
    # def self.included(base)
    #   base.module_eval do
    #     extend ClassMethods      
    #     has_many :translations, :as => :source
    #   end
    # end
    # 
    # def create_translation(locale)
    #   self.translations.create(locale)
    # end
    # 
    # module ClassMethods
    #   def translates(*fields)
    #     fields.each do |field|
    #       self.module_eval %Q{
    #         def #{field}
    #           if I18n.default?
    #             read_attribute(#{field})
    #           else
    #             get_translation_for(#{field}, I18n.locale) 
    #           end
    #         end
    #         
    #         def #{field}=(val)
    #           if I18n.default?
    #             write_attribute(#{field}, val)
    #           else
    #             set_translation_for(#{field}, I18n.locale, val)
    #           end
    #         end            
    #       }
    #     end        
    #   end
    # end
  end
end