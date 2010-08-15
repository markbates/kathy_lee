class FauxRecord
  
  attr_accessor :id
  attr_accessor :attributes
  
  def initialize(attributes = {})
    self.attributes = attributes
    @new_record = true
  end
  
  def new_record?
    @new_record
  end
  
  def save!
    @new_record = false
    rand.to_s.match(/\d+\.(.+)/)
    self.id = $1.to_i
    self.attributes.each do |name, attrib|
      attrib.save! if attrib.respond_to?(:save!)
      if attrib.is_a?(Array)
        attrib.each do |a|
          a.save! if a.respond_to?(:save!)
        end
      end
    end
  end
  
  def method_missing(sym, args = nil, &block)
    name = sym.to_s
    if name.match(/(.+)\=$/)
      self.attributes[$1.to_sym] = args
    end
    return self.attributes[sym]
  end
  
end