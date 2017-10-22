class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_email, :character_length


  has_many :comments


  def user_email
  	object.user.email
  end

  def character_length
  	object.content.length
  end


end
