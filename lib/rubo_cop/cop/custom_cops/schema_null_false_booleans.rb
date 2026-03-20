# frozen_string_literal: true

module RuboCop
  module Cop
    module CustomCops
      # ensures booleans fields in schema have null false
      class SchemaNullFalseBooleans < Cop
        MSG = 'Booleans must be null false'

        def on_send(node)
          return unless node.method_name == :boolean

          add_offense(node, location: :expression) unless null_false?(node)
        end

        private

        def null_false?(node)
          node.arguments.any? do |arg|
            arg.hash_type? && arg.pairs.any? do |pair|
              pair.key.sym_type? && pair.key.value == :null && pair.value.false_type?
            end
          end
        end
      end
    end
  end
end
