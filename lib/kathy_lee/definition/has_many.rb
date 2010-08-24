class KathyLee::Definition::HasMany < KathyLee::Definition::Relationship
  attr_accessor :size
  
  def initialize(factory, options = {})
    super(factory, options)
    self.size = (self.options.delete(:size) || 2)
  end
  
  def build
    results = []
    self.size.times do
      if self.klass
        results << self.klass
      else
        if self.code_block
          b = KathyLee::Definition::Binding.new(self.factory, self.options, self.code_block)
          b.process!
          results << b.result
        else
          results << KathyLee.build(self.factory, self.options)
        end
      end
    end
    [results].flatten
  end
  
end