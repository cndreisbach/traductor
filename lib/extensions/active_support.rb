module ActiveSupport
  class ModelName
    def initialize(name)
      super
      @singular = ActiveSupport::Inflector.underscore(self).tr('/', '_').freeze
      # ORIG: @plural = ActiveSupport::Inflector.pluralize(@singular).freeze
      @plural = ActiveSupport::Inflector.pluralize(@singular, I18n.default_locale).freeze
      @element = ActiveSupport::Inflector.underscore(ActiveSupport::Inflector.demodulize(self)).freeze
      @collection = ActiveSupport::Inflector.tableize(self).freeze
      @partial_path = "#{@collection}/#{@element}".freeze
    end
  end

  module CoreExtensions #:nodoc:
    module String #:nodoc:
      # String inflections define new methods on the String class to transform names for different purposes.
      # For instance, you can figure out the name of a database from the name of a class.
      #
      #   "ScaleScore".tableize # => "scale_scores"
      module Inflections
        # Returns the plural form of the word in the string.
        #
        #   "post".pluralize             # => "posts"
        #   "octopus".pluralize          # => "octopi"
        #   "sheep".pluralize            # => "sheep"
        #   "words".pluralize            # => "words"
        #   "the blue mailman".pluralize # => "the blue mailmen"
        #   "CamelOctopus".pluralize     # => "CamelOctopi"

        # Here, I added the ability to get an inflection for a particular locale.
        def pluralize(locale = nil)
          Inflector.pluralize(self, locale)
        end

        def singularize(locale = nil)
          Inflector.singularize(self, locale)
        end
      end
    end
  end

  module Inflector
    # Yields a singleton instance of Inflector::Inflections so you can specify additional
    # inflector rules.
    #
    # Example:
    #   ActiveSupport::Inflector.inflections do |inflect|
    #     inflect.uncountable "rails"
    #   end
    def inflections(locale = nil)
      locale ||= I18n.locale
      # locale_class = if locale.to_s == :en
      #         ActiveSupport::Inflector::Inflections
      #       else
      #         ActiveSupport::Inflector.const_get("Inflections_#{locale}") rescue nil
      #       end

      locale_class = ActiveSupport::Inflector.const_get("Inflections_#{locale}") rescue nil

      if locale_class.nil?
        ActiveSupport::Inflector.module_eval %{
          class ActiveSupport::Inflector::Inflections_#{locale} < ActiveSupport::Inflector::Inflections
          end
        }
        locale_class = ActiveSupport::Inflector.const_get("Inflections_#{locale}")
      end

      if block_given?
        yield locale_class.instance
      else
        locale_class.instance
      end
    end

    # Returns the plural form of the word in the string.
    #
    # Examples:
    #   "post".pluralize             # => "posts"
    #   "octopus".pluralize          # => "octopi"
    #   "sheep".pluralize            # => "sheep"
    #   "words".pluralize            # => "words"
    #   "CamelOctopus".pluralize     # => "CamelOctopi"
    def pluralize(word, locale = nil)
      locale ||= I18n.locale
      result = word.to_s.dup

      if word.empty? || inflections(locale).uncountables.include?(result.downcase)
        result
      else
        inflections(locale).plurals.each do |(rule, replacement)|
          if replacement.respond_to?(:call)
            break if result.gsub!(rule, &replacement)
          else
            break if result.gsub!(rule, replacement)
          end
        end
        result
      end
    end

    # The reverse of +pluralize+, returns the singular form of a word in a string.
    #
    # Examples:
    #   "posts".singularize            # => "post"
    #   "octopi".singularize           # => "octopus"
    #   "sheep".singluarize            # => "sheep"
    #   "word".singularize             # => "word"
    #   "CamelOctopi".singularize      # => "CamelOctopus"
    def singularize(word, locale = nil)
      locale ||= I18n.locale
      result = word.to_s.dup

      if inflections.uncountables.include?(result.downcase)
        result
      else
        inflections(locale).singulars.each do |(rule, replacement)|
          if replacement.respond_to?(:call)
            break if result.gsub!(rule, &replacement)
          else
            break if result.gsub!(rule, replacement)
          end
        end
        result
      end
    end

    # Create the name of a table like Rails does for models to table names. This method
    # uses the +pluralize+ method on the last word in the string.
    #
    # Examples
    #   "RawScaledScorer".tableize # => "raw_scaled_scorers"
    #   "egg_and_ham".tableize     # => "egg_and_hams"
    #   "fancyCategory".tableize   # => "fancy_categories"
    def tableize(class_name)
      class_name.to_s.underscore.humanize.downcase.pluralize(I18n.default_locale).tr(' ', '_')
    end
  end
end