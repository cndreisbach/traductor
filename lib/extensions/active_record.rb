module ActiveRecord
  class Base
    class << self
      # Transform the modelname into a more humane format, using I18n.
      # Defaults to the basic humanize method.
      # Default scope of the translation is activerecord.models
      # Specify +options+ with additional translating options.
      def human_name(options = {})
        defaults = self_and_descendants_from_active_record.map do |klass|
          :"#{klass.name.underscore}"
        end
        # changed humanize to titleize
        # This has been changed for multiple word names:
        # "EmergencyContacts".humanize => "Emergencycontacts"
        # "EmergencyContacts".titleize => "Emergency Contacts"
        defaults << self.name.titleize
        I18n.translate(defaults.shift, {:scope => [:activerecord, :models], :count => 1, :default => defaults}.merge(options))
      end

      private

      # Guesses the table name, but does not decorate it with prefix and suffix information.
      def undecorated_table_name(class_name = base_class.name)
        table_name = class_name.to_s.demodulize.underscore

        # ORIG: table_name = table_name.pluralize if pluralize_table_names
        # Table names should always be in the default locale
        table_name = table_name.tableize if pluralize_table_names
        table_name
      end
    end
  end

  module Reflection
    class AssociationReflection
      private
      def derive_class_name
        class_name = name.to_s.camelize
        
        # ORIG: class_name = class_name.singularize if [ :has_many, :has_and_belongs_to_many ].include?(macro)
        # Class names should always be in the default locate.
        class_name = class_name.singularize(I18n.default_locale) if [ :has_many, :has_and_belongs_to_many ].include?(macro)
        class_name
      end
    end
  end
end