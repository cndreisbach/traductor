module Traductor
  class Snippet < ActiveRecord::Base
    validates_presence_of :name, :en_text, :es_text
    validates_uniqueness_of :name
    validate :name_must_not_be_subset_of_other_name

    private

    def name_must_not_be_subset_of_other_name
      if self.name =~ /\./
        snippets = Snippet.find(:all, :conditions => ['name LIKE ?', "#{self.name}%"])
        snippets.reject! { |s| s.id == self.id } unless self.new_record?

        unless snippets.empty?
          errors.add(:name, "must not be a subset of another snippet name")
        end
      end
    end
    
  end
end