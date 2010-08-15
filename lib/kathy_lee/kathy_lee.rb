# Put your gem code here:

class KathyLee
  include Singleton
  
  attr_accessor :factories
  attr_accessor :factory_attributes
  
  def initialize
    self.factories = {}
    self.factory_attributes = {}
  end
  
  def build(factory_name, attributes = {})
    if self.factories[factory_name.to_sym]
      return self.factories[factory_name.to_sym].build(attributes)
    else
      self.define(factory_name, attributes) do
        object = factory_name.to_s.classify.constantize.new(options)
        object
      end
      self.build(factory_name, attributes)
    end
  end
  
  def create(factory_name, attributes = {})
    object = self.build(factory_name, attributes)
    object.save!
    return object
  end
  
  def attributes(factory_name, attributes = {}, &block)
    if block_given?
      self.factory_attributes[factory_name] = KathyLee::Attributes.new(attributes, &block)
    end
    if self.factory_attributes.has_key?(factory_name)
      return self.factory_attributes[factory_name].process(attributes)
    end
    return nil
  end
  
  def define(factory_name, attributes = {}, &block)
    self.factories[factory_name.to_sym] = KathyLee::Definition.new(factory_name, attributes, &block)
  end
  
  def sweatshop(factory_name, count = 2)
    results = []
    count.times do
      results << self.build(factory_name)
    end
    return results
  end
  
  def sweatshop!(factory_name, count = 2)
    results = self.sweatshop(factory_name, count)
    results.each {|x| x.save!}
    return results
  end
  
  class << self
    
    def method_missing(sym, *args, &block)
      KathyLee.instance.send(sym, *args, &block)
    end
    
  end
  
end
