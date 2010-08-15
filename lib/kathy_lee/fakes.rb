class KathyLee
  # A registry for procs that can be called to generate random, or fake, data.
  class Fakes
    include Singleton
  
    # List of all the fake procs in the system.
    attr_accessor :list
  
    def initialize # :nodoc:
      self.reset!
    end
  
    def reset! # :nodoc:
      self.list = {}
    end
  
    # Add a new proc to the system.
    # 
    # Example:
    #   KathyLee::Fakes.add(:birth_date) {(rand(80) + 13).years.ago}
    def add(name, &block)
      self.list[name.to_sym] = block
    end
    
    # Create an alias from one fake proc to another.
    # 
    # Example:
    #   KathyLee::Fakes.add(:birth_date) {(rand(80) + 13).years.ago}
    #   KathyLee::Fakes.alias(:birthday, :birth_date)
    def alias(from, to)
      self.list[from.to_sym] = KathyLee::Fakes::Alias.new(to)
    end
  
    # Executes the specified fake proc. Raise KathyLee::Errors::NoFakeRegistered
    # if the fake proc is not registered with the system.
    # 
    # Example:
    #   KathyLee::Fakes.execute(:email) # => 'bob@example.com'
    def execute(name, *args)
      block = self.list[name.to_sym]
      if block.is_a?(KathyLee::Fakes::Alias)
        return execute(block.to, *args)
      end
      if block
        return block.call(*args)
      end
      raise "No fake has been registered for '#{name}'!"
    end
  
    class << self
      def method_missing(sym, *args, &block) # :nodoc:
        KathyLee::Fakes.instance.send(sym, *args, &block)
      end
    end # class << self
  
    private
    class Alias # :nodoc:
      attr_accessor :to
      def initialize(to)
        self.to = to
      end
    end
    
  end # Fakes
end # KathyLee

%w{first_name last_name name prefix suffix}.each do |m|
  eval("KathyLee::Fakes.add(:#{m}) {|*args| Faker::Name.#{m}(*args)}")
end

%w{city city_prefix city_suffix secondary_address street_address street_name 
   street_suffix uk_country uk_county uk_postcode us_state us_state_abbr zip_code}.each do |m|
  eval("KathyLee::Fakes.add(:#{m}) {|*args| Faker::Address.#{m}(*args)}")
end

%w{bs catch_phrase name suffix}.each do |m|
  eval("KathyLee::Fakes.add(:#{m}) {|*args| Faker::Company.#{m}(*args)}")
end

%w{domain_name domain_suffix domain_word email free_email user_name}.each do |m|
  eval("KathyLee::Fakes.add(:#{m}) {|*args| Faker::Internet.#{m}(*args)}")
end

%w{paragraph paragraphs sentence sentences words}.each do |m|
  eval("KathyLee::Fakes.add(:#{m}) {|*args| Faker::Lorem.#{m}(*args)}")
end

%w{phone_number}.each do |m|
  eval("KathyLee::Fakes.add(:#{m}) {|*args| Faker::PhoneNumber.#{m}(*args)}")
end

KathyLee::Fakes.add(:url) {|*args| 'http://' + Faker::Internet.domain_name(*args)}
KathyLee::Fakes.add(:lorem) {|*args| Faker::Lorem.paragraphs(*args).join("\n")}
KathyLee::Fakes.add(:name) {|*args| Faker::Name.first_name + ' ' + Faker::Name.last_name}
KathyLee::Fakes.add(:birth_date) {|*args| (rand(80) + 13).years.ago}
KathyLee::Fakes.add(:title) {|*args| Faker::Company.catch_phrase.slice(0..250)}
KathyLee::Fakes.add(:username) {|*args| Faker::Internet.user_name}
KathyLee::Fakes.add(:company_name) {|*args| Faker::Company.name}
KathyLee::Fakes.alias(:login, :username)
KathyLee::Fakes.alias(:body, :lorem)
KathyLee::Fakes.alias(:full_name, :name)
