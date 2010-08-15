require 'singleton'
require 'active_support'

path = File.join(File.dirname(__FILE__), 'kathy_lee')

%w{kathy_lee definition definition/binding attributes attributes/binding}.each do |file|
  require File.expand_path(File.join(path, file))
end
