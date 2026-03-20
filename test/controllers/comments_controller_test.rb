# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test 'deleting a comment' do
    conversation = conversations(:fitpal_mentor_request_conversation)

    comment = conversation.comments.first

    given_signed_in_as :bob

    assert_difference 'conversation.comments.count', -1 do
      delete comment_path(comment)
    end

    assert_redirected_to conversation_comment_path(conversation)
  end
end
