require 'singleton'
require 'active_support'
require 'dummy'

# A monkey patch for dummy:
class Array
  def rand
    self.random_element
  end
end


path = File.join(File.dirname(__FILE__), 'kathy_lee')

%w{kathy_lee definition definition/binding definition/relationship 
   definition/has_one definition/has_many attributes attributes/binding fakes}.each do |file|
  require File.expand_path(File.join(path, file))
end
