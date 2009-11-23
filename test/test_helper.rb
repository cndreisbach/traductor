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

require 'fixtures/schema'

require File.join(File.dirname(__FILE__), '../init')
require "fixtures/oficina_de_turismo"
require "fixtures/site"







