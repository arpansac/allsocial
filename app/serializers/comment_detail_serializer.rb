class CommentDetailSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :user_id
end
