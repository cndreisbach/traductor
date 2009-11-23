require 'test_helper'

context "En español" do
  setup { I18n.default_locale = :es }

  context "OficinaDeTurismo" do
    should("have a human name") { OficinaDeTurismo.human_name }.equals "Oficina De Turismo"
    should("use the right table") { OficinaDeTurismo.table_name }.equals "oficinas_de_turismo"
  end

  context "a new record" do
    setup { OficinaDeTurismo.new(
        :nombre => Faker::Name.last_name,
        :calle => Faker::Address.street_address ) }

    should("save without exception") { topic.save! }
  end
end
