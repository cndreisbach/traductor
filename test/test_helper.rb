TestDir = lambda { |*paths| File.join(File.dirname(__FILE__), *paths) }
$:.push TestDir.call

require 'rubygems'
require 'riot'
require 'pp'
require 'faker'
require 'active_support'
require 'activerecord'

ActiveRecord::Base.establish_connection({
  :adapter => 'sqlite3',
  :database => ':memory:'
})

%w(schema oficina_de_turismo).each do |fixture|
  require "fixtures/#{fixture}"
end

require File.join(File.dirname(__FILE__), '../init')






