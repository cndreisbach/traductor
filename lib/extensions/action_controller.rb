module ActionController
  module PolymorphicRoutes
    def build_named_route_call(records, namespace, inflection, options = {})
      unless records.is_a?(Array)
        record = extract_record(records)
        route  = ''
      else
        record = records.pop
        route = records.inject("") do |string, parent|
          if parent.is_a?(Symbol) || parent.is_a?(String)
            string << "#{parent}_"
          else
            string << "#{RecordIdentifier.__send__("plural_class_name", parent)}".singularize
            string << "_"
          end
        end
      end

      if record.is_a?(Symbol) || record.is_a?(String)
        route << "#{record}_"
      else
        route << "#{RecordIdentifier.__send__("plural_class_name", record)}"
        route = route.singularize(I18n.default_locale) if inflection == :singular
        route << "_"
      end

      action_prefix(options) + namespace + route + routing_type(options).to_s
    end
  end
end
