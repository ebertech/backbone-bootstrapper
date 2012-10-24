module Backbone
  module Bootstrapper
    module Helper
      class << self
        def included(base)
          base.class_eval do
            include InstanceMethods
            helper_method :backbone_bootstraps
          end
        end
      end
      
      module InstanceMethods
        def backbone_bootstraps
          @template.javascript_tag do               
            (@bootstrappers || []).map do |bootstrapper| 
              [bootstrapper.declaration, bootstrapper.initialization].join("\n")
            end.join("\n")
          end
        end
        
        def bootstrap_backbone(key, object, template, type = nil)
          @bootstrappers ||= []
          @bootstrappers << if object.is_a?(Array)
            Bootstrapper::Collection.new(key, object, template, type)
          else
            Bootstrapper::Model.new(key, object, template, type)
          end
        end
      end
    end
  end
end