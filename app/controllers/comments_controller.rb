class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_comment, only: [:destroy]
  before_action :authorize_user, only: [:destroy]


  def create

  	@comment = Comment.new(comment_params)
  	@comment.user = current_user
  	@comment.save
    @post = @comment.post

    UserMailer.new_comment_email(@comment).deliver_now

  end

  def destroy
  	@comment_id = @comment.id

  	@comment.destroy
  end

  private

  def comment_params
  	params.require(:comment).permit(:post_id, :content)
  end

  def set_comment
  	@comment = Comment.find(params[:id])
  end

  def authorize_user
  	if @comment.user != current_user
  		return redirect_to root_path
  	end
  	return true

  end
end
