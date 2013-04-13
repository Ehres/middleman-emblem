require 'sprockets'
require 'sprockets/engines'
require 'barber-emblem'
require "#{File.dirname(__FILE__)}/sprockets-old"

module Middleman
  module Emblem
    class Template < Ember::Handlebars::Template

      def evaluate(scope, locals, &block)
        target = template_target(scope)


        template = data

        if true
          if false
            template = precompile_emblem(template)
          else
            template = precompile_ember_emblem(template)
          end
        else
          if raw
            template = compile_emblem(data)
          else
            template = compile_ember_emblem(template)
          end
        end

        "#{target} = #{template}\n"
      end

      private

      def raw?(scope)
        scope.pathname.to_s =~ /\.raw\.(emblem)/
      end

      def compile_emblem(string)
        "Handlebars.compile(#{indent(string).inspect});"
      end

      def precompile_emblem(string)
        Barber::Emblem::FilePrecompiler.call(string)
      end

      def compile_ember_emblem(string)
        "Emblem.compile(Ember.Handlebars, #{indent(string).inspect});"
      end

      def precompile_ember_emblem(string)
        Barber::Emblem::EmberFilePrecompiler.call(string)
      end
    end
  end
end