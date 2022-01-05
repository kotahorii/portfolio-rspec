class Api::V1::RatesController < ApplicationController
  def create
    rate = current_api_v1_user.rates.new(rate_params)
    post = Post.find_by(id: rate.post_id)
    if rate.save
      render status: 201, json: post, serializer: PostSerializer
    else
      render status: 401, json: { data: '作成に失敗しました' }
    end
  end

  def update
    rate = Rate.find(params[:id])
    post = Post.find_by(id: rate.post_id)

    if rate.update(rate: rate_params[:rate], post_id: rate_params[:post_id], user_id: current_api_v1_user.id)
      render status: 200, json: post, serializer: PostSerializer
    else
      render status: 401, json: { data: '更新に失敗しました' }
    end
  end

  private

  def rate_params
    params.permit(:post_id, :rate)
  end
end
