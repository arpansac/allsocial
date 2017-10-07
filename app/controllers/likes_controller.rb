class LikesController < ApplicationController
	before_action :authenticate_user!


	def toggle_post_like
		@post = Post.find(params[:post_id])
		@new_like_status = 'Unlike'

		if @post.user_can_like(current_user)
			Like.create(
				user: current_user,
				likeable: @post
				)
		else
			Like.find_by(
				user: current_user,
				likeable: @post
				).destroy
			@new_like_status = 'Like'

		end 

	end


	def toggle_comment_like
		@comment = Post.find(params[:comment_id])
		@new_like_status = 'Unlike'

		if @comment.user_can_like(current_user)
			Like.create(
				user: current_user,
				likeable: @comment
				)
		else
			Like.find_by(
				user: current_user,
				likeable: @comment
				).destroy
			@new_like_status = 'Like'

		end 
	end

end
