require 'rubygems'
require 'rspec'

require File.join(File.dirname(__FILE__), '..', 'lib', 'kathy_lee')

require File.join(File.dirname(__FILE__), 'support', 'faux_record')
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require File.expand_path(f)}

Rspec.configure do |config|
  
  config.before(:all) do
    
  end
  
  config.after(:all) do
    
  end
  
  config.before(:each) do
    
  end
  
  config.after(:each) do
    
  end
  
end
