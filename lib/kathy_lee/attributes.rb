class KathyLee::Attributes
  
  attr_accessor :attributes
  attr_accessor :code_block
  
  def initialize(attributes = {}, &block)
    self.attributes = attributes
    self.code_block = block
  end
  
  def process(attribs = {})
    b = KathyLee::Attributes::Binding.new(self.attributes.merge(attribs), &self.code_block)
    b.process!
    return b.results
  end
  
  
end