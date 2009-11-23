class Site < ActiveRecord::Base
  include Traductor::Translatable
  
  # translates :name, :description
end