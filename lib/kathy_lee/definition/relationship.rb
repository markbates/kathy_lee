class KathyLee::Definition::Relationship
  attr_accessor :options
  attr_accessor :code_block
  attr_accessor :klass
  attr_accessor :factory
  
  def initialize(factory, options = {})
    self.factory = factory
    self.options = options
    self.klass = self.options.delete(:klass)
    self.code_block = self.options.delete(:code_block)
  end
  
end