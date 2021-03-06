class KathyLee::Attributes::Binding
  
  attr_accessor :results
  attr_accessor :attributes
  attr_accessor :code_block
  
  def initialize(attributes = {}, &block)
    self.results = {}
    self.attributes = attributes
    self.code_block = block
  end
  
  def process!
    if self.code_block
      instance_eval(&self.code_block)
    end
    self.results.merge!(self.attributes)
  end
  
  def fake(name)
    KathyLee::Fakes.execute(name)
  end
  
  def method_missing(sym, args = nil, &block)
    self.results[sym] = args unless args.nil?
    if block_given?
      self.results[sym] = block.call
    end
  end
  
end