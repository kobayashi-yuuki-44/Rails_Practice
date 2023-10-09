class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
  end
  
  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
   end