require 'spec_helper'

describe KathyLee::Definition::Binding do
  
  describe "initialize" do
    
    before(:each) do
      KathyLee.attributes(:corn) do
        tasty('yes')
        color('yellow')
      end
      KathyLee.attributes(:bad_corn) do
        tasty('no')
        color('brown')
      end
      KathyLee.define(:corn) do
        options
      end
    end
    
    it "should use previously defined attributes for the factory" do
      b = KathyLee::Definition::Binding.new(:corn)
      b.options.should == {:tasty => 'yes', :color => 'yellow'}
    end
    
    it "should merge in new attributes to the defined factory attributes" do
      b = KathyLee::Definition::Binding.new(:corn, :tasty => 'hell yeah!')
      b.options.should == {:tasty => 'hell yeah!', :color => 'yellow'}
    end
    
    it "should use attributes_for to find other attributes" do
      b = KathyLee::Definition::Binding.new(:corn, :attributes_for => :bad_corn, :tasty => 'definitely not!')
      b.options.should == {:tasty => 'definitely not!', :color => 'brown'}
    end
    
  end
  
end
