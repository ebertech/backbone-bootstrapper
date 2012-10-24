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
        @object.map do |item|
          Rabl::Renderer.json(object, template, :view_path => 'app/views', :object => object)        
        end.join("\n")
      end  
    end
  end
end