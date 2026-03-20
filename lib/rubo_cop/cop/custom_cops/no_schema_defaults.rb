# frozen_string_literal: true

module RuboCop
  module Cop
    module CustomCops
      # This cop checks for the presence of a :default node in the AST.
      # If it finds one, it adds an offense.
      class NoSchemaDefaults < Cop
        MSG = 'No schema defaults allowed. Please set a default in the model instead. ' \
              'For migrations of old data, please use "#change_column_default" to remove the default.'

        def_node_matcher :default_pair, <<-PATTERN
          (pair (sym :default) _)
        PATTERN

        def on_pair(node)
          return unless default_pair(node)

          add_offense(node, message: MSG)
        end
      end
    end
  end
end
