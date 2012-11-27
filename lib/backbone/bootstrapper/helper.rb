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
          with_javascript_tag do
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

        private
        def with_javascript_tag(&block)
          context = @template.respond_to?(:javascript_tag) ? @template : view_context
          context.javascript_tag do 
            result = block.call
            if result.respond_to?(:html_safe)
              result.html_safe 
            else
              result
            end
          end
        end
      end
    end
  end
end