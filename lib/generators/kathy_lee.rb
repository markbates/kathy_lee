require 'rails/generators/named_base'

class KathyLee
  module Generators
    class Base < Rails::Generators::NamedBase #:nodoc:
      def self.source_root
        @_kathy_lee_source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'kathy_lee', 'model', 'templates'))
      end
    end
  end
end