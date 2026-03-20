# frozen_string_literal: true

# Manages comments
class CommentsController < ApplicationController
  before_action :set_comment
  authorized_when { @comment.user == current_user }

  def destroy
    @comment.destroy!

    respond_with @comment.conversation, location: conversation_comment_path(@comment.conversation)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
