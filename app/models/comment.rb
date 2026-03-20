# frozen_string_literal: true

# A comment for a conversation
class Comment < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
end
