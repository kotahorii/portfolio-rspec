class PostSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :title, :body, :prefecture, :city, :town, :image, :lat, :lng, :created_at, :favorites, :comments, :labels, :rates
end
