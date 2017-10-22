class PostAuthSerializer < ActiveModel::Serializer
  attributes :id, :content, :user


  has_many :comments, serializer: CommentDetailSerializer
end
