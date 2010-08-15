require 'spec_helper'

describe KathyLee::Definition do
  
  describe "build" do
    
    it "should return the result of a definition" do
      d = KathyLee::Definition.new(:brent, :movie => 'Cloudy') do
        options.merge({:nickname => 'baby brent'})
      end
      d.build.should == {:movie => 'Cloudy', :nickname => 'baby brent'}
      d.build(:movie => 'Meatballs').should == {:movie => 'Meatballs', :nickname => 'baby brent'}
    end
    
  end
  
end
