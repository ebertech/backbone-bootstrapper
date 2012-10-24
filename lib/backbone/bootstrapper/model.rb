module Backbone
  module Bootstrapper
    class Model < Base
      def initialize(*args)
        super
        @type ||= "Backbone.Model"
      end

      def initialization
        %Q{#{@key}.set(#{@value});}
      end
      
      def render
        Rabl::Renderer.json(@object, @template, :view_path => 'app/views', :object => @object)        
      end
    end
  end
end