require 'test_helper'

context "with a translatable Site" do
  setup { 
    Site.new(
      :name => 'Lucky Strike Tower', 
      :description => "An old water tower with a cigarette sign on it.",
      :city => 'Durham, NC')
  }
  
  # should("be able to create a new translation") { topic.create_translation(:es) }
end