class Api::V1::UsersController < ApplicationController
  def index
    users = User.all.order(created_at: 'DESC')
    render json: users
  end

  def update
    user = User.find(params[:id])
    user.name = user_params[:name]
    user.introduction = user_params[:introduction]
    user.prefecture = user_params[:prefecture]
    user.image = user_params[:image] if user_params[:image] != ''

    if user.save
      render status: 200, json: user
    else
      render status: 401, json: { message: '更新に失敗しました' }
    end
  end

  private

  def user_params
    params.permit(:name, :introduction, :prefecture, :image)
  end
end
