# Used to evaluate a KathyLee::Definition in it's own 'space' (binding)
class KathyLee::Definition::Binding
  
  attr_accessor :options
  attr_accessor :code_block
  attr_accessor :result
  attr_accessor :has_ones
  attr_accessor :has_manys
  
  def initialize(factory_name, attributes = {}, &block)
    attrib_name = attributes.delete(:attributes_for) || factory_name.to_sym
    self.options = (KathyLee.attributes(attrib_name) || {}).merge(attributes)
    self.code_block = block
    self.has_ones = {}
    self.has_manys = {}
  end
  
  def has_one(factory, options = {}, &block)
    self.has_ones[factory.to_sym] = {:options => options, :code_block => block, 
                                     :klass => self.options.delete(factory.to_sym)}
  end
  
  def has_many(factory, options = {}, &block)
    options = {:size => 2}.merge(options)
    self.has_manys[factory.to_sym] = KathyLee::Definition::HasMany.new(factory.to_sym, {:options => options, :code_block => block, :klass => self.options.delete(factory.to_sym)})
  end
  
  def process!
    self.result = instance_eval(&self.code_block)
    handle_has_ones
    handle_has_manys
  end
  
  protected
  def handle_has_ones
    self.has_ones.each do |factory, h|
      if h[:klass]
        self.result.send("#{factory}=", h[:klass])
      else
        if h[:code_block]
          b = KathyLee::Definition::Binding.new(factory, h[:options], &h[:code_block])
          b.process!
          self.result.send("#{factory}=", b.result)
        else
          self.result.send("#{factory}=", KathyLee.build(factory, h[:options]))
        end
      end
    end
  end
  
  def handle_has_manys
    self.has_manys.each do |factory, h|
      h.build.each do |obj|
        self.result.send("#{factory}") << obj
      end
    end
  end
  
end