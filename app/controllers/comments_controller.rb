class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_comment, only: [:destroy]
  before_action :authorize_user, only: [:destroy]


  def create

  	@comment = Comment.new(comment_params)
  	@comment.user = current_user
  	@comment.save
    @post = @comment.post

    Resque.enqueue(CommentEmailWorker, @comment.id)

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




# User adds comment --> Rails Server [controller]

# --> Comment added --> Show on page


# --> Request added to queue on Redis using Resque --> Resque Executes the tasks from redis 
# one by one[Send Comment Email]


# All the things which are running

# Rails Server
# Redis Server
# Resque Workers
















