class Api::V1::LabelsController < ApplicationController
  def create
    label = current_api_v1_user.labels.new(label_params)
    post = Post.find_by(id: label.post_id)
    if label.save
      render status: 201, json: post, serializer: PostSerializer
    else
      render status: 401 json: { data: '作成に失敗しました'}
    end
  end

  def destroy
    label = Label.find(params[:id])
    post = Post.find_by(id: label.post_id)
    if label.destroy
      render status: 200, json: post, serializer: PostSerializer
    else
      render status: 401 json: { data: '削除に失敗しました' }
    end
  end

  private

  def label_params
    params.permit(:name, :post_id)
  end
end
