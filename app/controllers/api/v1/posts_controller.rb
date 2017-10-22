module Api

	module V1
		class PostsController < ApplicationController

			def index
				@posts = Post.all
				if !user_signed_in?
			        return render json: {'message': 'Error'},status: 401
			      else
			        return render json: {
			        	'posts': @posts,
			        	'comments': Comment.all

			        	}, each_serializer: PostAuthSerializer 
			      end
			 
			end

		end
	end
end