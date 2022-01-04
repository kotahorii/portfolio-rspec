class Api::V1::FavoritesController < ApplicationController
  def create
    favorite = current_api_v1_user.favorites.new(favorite_params)
    post = Post.find_by(id: favorite.post_id)
    if favorite.save
      render json: post, serializer: PostSerializer
    else
      render json: { data: '作成に失敗しました' }
    end
  end

  def destroy
    favorite = Favorite.find(params[:id])
    post = Post.find_by(id: favorite.post_id)
    if favorite.destroy
      render json: post, serializer: PostSerializer
    else
      render json: { data: '削除に失敗しました' }
    end
  end

  private

  def favorite_params
    params.permit(:post_id)
  end
end
