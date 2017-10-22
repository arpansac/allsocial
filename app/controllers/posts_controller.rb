class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_post, only: [:destroy]
  before_action :authorize_user, only: [:destroy]


  skip_before_action :verify_authenticity_token, only: [:create_api]
  before_action :authenticate_user_custom, only: [:create_api]


  def create_api
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save
    return render json: {
            'message': 'Request Successful',
            'posts': @post
          }, serialization_key: 'authenticated'
  end

  def index
    query = params[:q]
  	@post = Post.new
  	
    if (query.blank?)
      @posts = Post.all
    else
  	 @posts = Post.where('content like ?', ('%' + query + '%')).reverse()
    end
    
    @page = params[:page].blank? ? 1 : params[:page].to_i
    @count = params[:count].blank? ? 2 : params[:count].to_i
   
    @max_pages = @posts.length/@count


    @posts = @posts.offset(@count * (@page-1)).limit(@count)

    @comment = Comment.new

    respond_to do |format|
      format.html
      format.js

      if !user_signed_in?
        s_key = 'unauthenticated'
        
      else
        s_key = 'authenticated'
      end

       format.json { render json: {
            'message': 'Request Successful',
            'posts': @posts
          }, serialization_key: s_key }
    end

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











