module Backbone
  module Bootstrapper
    class Base
      def initialize(key, object, template, type = nil)
        @key = key
        @object = object
        @template = template
        @type = type
        
        @value = render
      end

      def declaration
        %Q{#{@key} = new #{@type};}
      end
      
      def render
        raise NotImplementedError
      end
    end
  end
end