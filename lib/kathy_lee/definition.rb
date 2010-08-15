# Houses the definition of a factory.
# 
# Examples:
#   KathyLee.define(:user) do
#     user = User.new(options)
#     ... # do some more work
#     user
#   end
# 
#   KathyLee.define(:user) do
#     has_one :blog # will call the :blog factory and assign it to the
#                   # user object when it's returned from the block.
# 
#     user = User.new(options)
#     ... # do some more work
#     user
#   end
class KathyLee::Definition
  
  attr_accessor :factory_name
  attr_accessor :attributes
  attr_accessor :code_block
  
  def initialize(factory_name, attributes = {}, &block)
    self.attributes = attributes
    self.factory_name = factory_name
    self.code_block = block
  end
  
  # Execute the code block in it's own building, with it's own attributes
  # and return the result.
  def build(attribs = {})
    b = KathyLee::Definition::Binding.new(self.factory_name, self.attributes.merge(attribs), &self.code_block)
    b.process!
    return b.result
  end
  
end