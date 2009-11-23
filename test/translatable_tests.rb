require 'test_helper'

context "with a translatable Site" do
  setup {
    I18n.default_locale = :en
    I18n.locale = :en
    Site.new(
      :name => 'Lucky Strike Tower', 
      :description => "An old water tower with a cigarette sign on it.",
      :city => 'Durham, NC')
  }
  
  # should("be able to get a new translation") { 
  #   topic.get_translation(:es) }.kind_of(Traductor::Translation)
end