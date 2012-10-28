module Backbone
  module Bootstrapper
    class Collection < Base
      def initialize(*args)
        super
        @type ||= "Backbone.Collection"
      end

      def initialization
        %Q{#{@key}.reset(#{@value});}
      end
            
      def render
        Rabl::Renderer.json(@object, @template, :view_path => 'app/views', :object => @object)        
      end  
    end
  end
end