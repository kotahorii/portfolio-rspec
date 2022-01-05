class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]

  def index
    posts = Post.all.order(created_at: 'DESC')
    render status: 200, json: posts, each_serializer: PostSerializer
  end

  def show
    render status: 200, json: @post, serializer: PostSerializer
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_api_v1_user.id
    if post.save
      render status: 201, json: post, serializer: PostSerializer
    else
      render status: 401, json: { data: '投稿に失敗しました' }
    end
  end

  def update
    @post.title = post_params[:title]
    @post.body = post_params[:body]
    @post.prefecture = post_params[:prefecture]
    @post.city = post_params[:city]
    @post.town = post_params[:town]
    @post.lat = post_params[:lat]
    @post.lng = post_params[:lng]
    @post.image = post_params[:image] if post_params[:image] != ''
    @post.user_id = current_api_v1_user.id

    if @post.save
      render status: 200, json: @post, serializer: PostSerializer
    else
      render status: 401, json: { data: '更新に失敗しました' }
    end
  end

  def destroy
    if @post.destroy
      render status: 200, json: { data: '投稿を削除しました' }
    else
      render status: 401, json: { data: '削除に失敗しました' }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.permit(:title, :body, :prefecture, :city, :town, :image, :lat, :lng)
  end
end
