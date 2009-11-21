require 'test_helper'

context "I18n with :es" do
  setup do
    I18n.default_locale = :es
    I18n.backend.load_translations(TestDir['fixtures/locales.yml'])
  end

  asserts("default locale is set") { I18n.locale == :es }

  should("pluralize irregulars") { "papá".pluralize }.matches("papás")
  should("pluralize correctly") { "contacto de emergencia".pluralize }.matches("contactos de emergencia")
  should("pluralize articles correctly") { "el contacto de emergencia".pluralize }.matches("los contactos de emergencia")

  should("singularize irregulars") { "mamás".singularize }.matches("mamá")
  should("singularize correctly") { "contactos de emergencia".singularize }.matches("contacto de emergencia")
  should("singularize articles correctly") { "los contactos de emergencia".singularize }.matches("el contacto de emergencia")

  should("translate and singularize") { I18n.t(:tourism_office).pluralize }.matches("oficinas de turismo")
  should("translate and singularize into English") {
    I18n.t(:tourism_office, :locale => :en).pluralize(:en)
  }.matches("tourism offices")
end
