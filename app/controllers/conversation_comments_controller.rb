# frozen_string_literal: true

class ConversationCommentsController < ApplicationController
  before_action :load_conversation
  authorized_when { @conversation.can_user_manage?(current_user) }

  def show
    @comment = Comment.new
    @comments = @conversation.comments.order(created_at: :desc)
  end

  def update
    @conversation.comments.create!(
      conversation_comment_params.merge(user: current_user)
    )

    respond_with @conversation, location: conversation_comment_path(@conversation)
  end

  private

  def conversation_comment_params
    params.require(:comment).permit(:message)
  end

  def load_conversation
    @conversation = Conversation.find(params[:id])
  end
end
