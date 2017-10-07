class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes


  has_many :friendships
  has_many :friends, through: :friendships


  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  has_many :inverse_friends, through: :inverse_friendships, source: :user


  def get_all_friends
  	friend_ids = self.friends.all.pluck(:id)

  	inverse_friend_ids = self.inverse_friends.all.pluck(:id)

  	all_friends = friend_ids + inverse_friend_ids

  	return User.where('id in (?)', all_friends)

  end

end












