require 'test_helper'

context "I18n with :es" do
  setup do
    I18n.default_locale = :es
    I18n.backend.load_translations(TestDir['fixtures/locales.yml'])
  end

  asserts("default locale is set") { I18n.locale == :es }

  should("pluralize irregulars") { "papá".pluralize }.equals("papás")
  should("pluralize correctly") { "contacto de emergencia".pluralize }.equals("contactos de emergencia")
  should("pluralize articles correctly") { "el contacto de emergencia".pluralize }.equals("los contactos de emergencia")

  should("singularize irregulars") { "mamás".singularize }.equals("mamá")
  should("singularize correctly") { "contactos de emergencia".singularize }.equals("contacto de emergencia")
  should("singularize articles correctly") { "los contactos de emergencia".singularize }.equals("el contacto de emergencia")

  should("translate and singularize") { I18n.t(:tourism_office).pluralize }.equals("oficinas de turismo")
  should("translate and singularize into English") {
    I18n.t(:tourism_office, :locale => :en).pluralize(:en)
  }.equals("tourism offices")

  should("tableize correctly") { "OficinaDeTurismo".tableize }.equals "oficinas_de_turismo"
end
