class KathyLee::Definition
  
  attr_accessor :factory_name
  attr_accessor :attributes
  attr_accessor :code_block
  
  def initialize(factory_name, attributes = {}, &block)
    self.attributes = attributes
    self.factory_name = factory_name
    self.code_block = block
  end
  
  def build(attribs = {})
    b = KathyLee::Definition::Binding.new(self.factory_name, self.attributes.merge(attribs), &self.code_block)
    b.process!
    return b.result
  end
  
end