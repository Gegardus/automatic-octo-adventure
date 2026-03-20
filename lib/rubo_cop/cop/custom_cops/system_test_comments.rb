# frozen_string_literal: true

module RuboCop
  module Cop
    module CustomCops
      # System tests must have Given/When/Then comments
      class SystemTestComments < RuboCop::Cop::Cop
        def investigate(processed_source)
          on_node(%i[send], processed_source.ast) do |send_node|
            if send_node.method_name == :test
              process_test_send_node(send_node)
            end
          end
        end

        private

        def allowed_comment_intros
          main_keyword_intros + [
            '# And ',
            '# But ',
            '# TODO: ',
            '# NOTE: ',
            '# FIX' + ' ME: ', # rubocop:disable Style/StringConcatenation
            '# rubocop'
          ]
        end

        def main_keyword_intros
          [
            '# Given ',
            '# When ',
            '# Then '
          ]
        end

        def process_test_send_node(send_node)
          comments_in_test = processed_source.comments.select do |comment|
            comment_in_test?(comment, send_node)
          end
          check_comments_are_allowed(comments_in_test)
          check_comments_flow(send_node, comments_in_test)
          check_comments_include_then(send_node, comments_in_test)
        end

        def check_comments_are_allowed(comments_in_test)
          comments_in_test.each do |comment|
            unless allowed_comment_intros.any? { |intro| comment.text.start_with?(intro) }
              add_offense(comment, location: :expression, message: not_allowed_message)
            end
          end
        end

        def check_comments_flow(send_node, comments_in_test)
          return unless comments_in_test.none? { |c| main_keyword_intros.any? { |k| c.text.start_with?(k) } }

          add_offense(send_node, location: :expression, message: 'has no Given/When/Then comments')
        end

        def comment_in_test?(comment, send_node)
          comment.location.line > send_node.parent.location.begin.line &&
            comment.location.line < send_node.parent.location.end.line
        end

        def check_comments_include_then(send_node, comments_in_test)
          has_when_and_then_steps = comments_in_test.any? { |comment| comment.text.start_with?('# When ') } &&
                                    comments_in_test.any? { |comment| comment.text.start_with?('# Then ') }

          return if has_when_and_then_steps

          add_offense(send_node, location: :expression, message: 'must have both When and Then comments')
        end

        def not_allowed_message
          "system test comments must start with #{allowed_comment_intros.join('or ').strip}"
        end
      end
    end
  end
end
