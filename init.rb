$:.push File.dirname(__FILE__)

require 'lib/extensions/active_record'
require 'lib/extensions/active_support'
require 'lib/extensions/action_controller'
require 'lib/inflectors'
require 'lib/traductor/snippet'
require 'lib/traductor/snippet_backend'
require 'lib/traductor/translatable'
require 'lib/traductor/translation'