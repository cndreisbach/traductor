require 'test_helper'

context "using Snippet backend" do
  setup {
    I18n.default_locale = :en
    require TestDir['fixtures/snippet_seeds']
    I18n.backend = Traductor::SnippetBackend.new    
  }
  
  asserts("can lookup snippet") { I18n.t :greeting, :locale => :en }.equals("Hello!")
  asserts("can lookup snippet in Spanish") { 
    I18n.t :farewell, :locale => :es }.equals("¡Hasta luego!")
    
  should("handle nested keys correctly") {
    I18n.t %s[pets.feline], :locale => :es }.equals("gato")
end