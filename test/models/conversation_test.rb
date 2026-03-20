# frozen_string_literal: true

require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
  test 'can_user_manage?' do
    conversation = conversations(:fitpal_mentor_request_conversation)

    assert conversation.can_user_manage?(users(:bob))
    assert conversation.can_user_manage?(users(:dom))
    assert conversation.can_user_manage?(users(:kali))

    assert_not conversation.can_user_manage?(users(:jim))
  end
end
