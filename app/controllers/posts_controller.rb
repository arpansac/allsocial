class PostsController < ApplicationController
  before_action :authenticate_user, only: [:create, :destroy]
  before_action :set_post, only: [:destroy]
  before_action :authorize_user, only: [:destroy]

  def index
  	@post = Post.new
  	@posts = Post.all
  end

  def create

  	@post = Post.new(post_params)
  	@post.user = current_user

  	return redirect_to action: "index"

  end

  def destroy

  	@post.destroy
  	return redirect_to action: "index"
  end

  private

  def post_params
  	params.permit(:post).permit(:content)
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
