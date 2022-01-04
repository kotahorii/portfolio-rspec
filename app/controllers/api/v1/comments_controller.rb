class Api::V1::CommentsController < ApplicationController
  def create
    comment = current_api_v1_user.comments.new(comment_params)
    post = Post.find_by(id: comment.post_id)
    if comment.save
      render json: post, serializer: PostSerializer
    else
      render json: { data: '作成に失敗しました'}
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    post = Post.find_by(id: comment.post_id)
    if comment.destroy
      render json: post, serializer: PostSerializer
    else
      render json: { data: '削除に失敗しました' }
    end
  end

  private

  def comment_params
    params.permit(:comment, :post_id)
  end
end
