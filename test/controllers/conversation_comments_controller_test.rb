# frozen_string_literal: true

require 'test_helper'

class ConversationCommentsControllerTest < ActionDispatch::IntegrationTest
  test 'create adds comments' do
    given_signed_in_as :bob
    conversation = conversations(:fitpal_mentor_request_conversation)

    assert_difference 'conversation.comments.count' do
      patch conversation_comment_path(conversation), params: {
        comment: {
          message: 'Please respond quickly'
        }
      }
    end

    assert_redirected_to conversation_comment_path(conversation)
  end

  test 'show' do
    given_signed_in_as :bob
    conversation = conversations(:fitpal_mentor_request_conversation)

    get conversation_comment_path(conversation)

    assert_text conversation.comments.first.message
  end
end
