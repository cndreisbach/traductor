module Traductor
  class Translation < ActiveRecord::Base
    belongs_to :source, :polymorphic => :true
    validates_presence_of :locale
    validates_presence_of :fields
    validates_uniqueness_of :source_id, :source_type, :locale
  end
end