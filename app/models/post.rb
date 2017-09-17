class Post < ActiveRecord::Base
	validates :user, presence: true

	belongs_to :user
	has_many :comments, dependent: :destroy
end
