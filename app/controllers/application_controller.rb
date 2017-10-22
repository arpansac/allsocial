class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  def authenticate_user_api

  	authenticate_with_http_token do |token, options|
  	
  		@current_user = User.find_by_access_token(token)

  		if (@current_user.blank? || !@current_user.access_token_is_valid)
  			return false
  		else

  			return true
  		end
  	end

  	def authenticate_user_custom
  		if user_signed_in?
  			@current_user = current_user
  			return true
  		else
  			mobile_user = authenticate_user_api
  			if !mobile_user
  				return render json: {
  				'message': 'unauthorized',
	  			},
	  			status: 401
  			end
  			return true

  		end

  	end

  end
end
