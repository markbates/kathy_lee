require 'spec_helper'

describe KathyLee::Attributes do
  
  describe "method_missing" do
    
    it "should set the attributes" do
      at = KathyLee::Attributes.new(:foo => 'bar') do
        name 'Mark Bates'
      end
      res = at.process
      res.should == {:foo => 'bar', :name => 'Mark Bates'}
    end
    
  end
  
end
