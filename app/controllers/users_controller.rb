class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
	end


	def filter_by_email
		users = User.where('email like ?', ('%' + params[:term] + '%'))

		users_list = []
		users.each do |u|
			user = Hash.new
			user[:id] = u.id 
			user[:value] = u.email
			user[:label] = u.email
			users_list << user
		end

		return render json: users_list
	end

	def update
		user = User.find(params[:id])
		user.update(
			email: params[:user][:email],
			profile_picture: params[:user][:profile_picture]
			)
		byebug
		return redirect_to user_show_path(user.id)
	end

end











