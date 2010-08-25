require 'generators/kathy_lee'

class KathyLee
  module Generators
    class ModelGenerator < Base
      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"
      class_option :dir, :type => :string, :default => "spec/factories", :desc => "The directory where the factories should go"
      
      def create_fixture_file
        template 'fixtures.rb', File.join(options[:dir], "#{singular_name}_factories.rb")
      end
    end
  end
end