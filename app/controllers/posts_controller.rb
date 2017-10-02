class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_post, only: [:destroy]
  before_action :authorize_user, only: [:destroy]

  def index
  	@post = Post.new
  	@comment = Comment.new
  	@posts = Post.all.reverse()
  end

  def create
  	@post = Post.new(post_params)
  	@post.user = current_user
  	@post.save
  	@comment = Comment.new
  end

  def destroy
    @post_id = @post.id
  	@post.destroy
  	
  end

  private

  def post_params
  	params.require(:post).permit(:content)
  end

  def set_post
  	@post = Post.find(params[:id])
  end

  def authorize_user
  	if @post.user != current_user
  		return redirect_to root_path
  	end
  	return true

  end

end
