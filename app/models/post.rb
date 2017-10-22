class Post < ActiveRecord::Base
	validates :user, presence: true

	belongs_to :user
	has_many :comments, dependent: :destroy

	has_many :likes, as: :likeable


	def as_json(options = {})
		if options[:serialization_key] == 'unauthenticated'
			return PostSerializer.new(self).as_json
		else
			return PostAuthSerializer.new(self).as_json
		end
	end


	def user_can_like(user)
		return self.likes.find_by(user: user).blank?
	end

	def current_like_status(user)
		if user_can_like(user)
			return 'Like'
		else
			return 'Unlike'
		end
	end

end
