class LikesController < ApplicationController



	def toggle_post_like
		@can_like = false
		@post = Post.find(params[:post_id])
		like = Like.find_by(user: current_user, likeable: post)

		if like.blank?
			like Like.new(..)
		else
			like.destroy
			@can_like = true
		end
		
	end

	def toggle_comment_like
		liked = false

		like = Like.find_by(user: current_user, )
	end

end