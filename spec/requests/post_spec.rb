require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :request do
  let!(:user) { create(:user) }
  let!(:headers) { user.create_new_auth_token }
  let(:json) { JSON.parse(response.body) }

  describe 'GET #index' do
    let!(:post) { create(:post) }
    before do
      get api_v1_posts_path, headers: headers
    end

    it 'HTTPステータスが200であること' do
      expect(response.status).to eq(200)
    end

    it 'jsonで正しい投稿が取得されること' do
      expect(json[0]['title']).to eq 'test'
    end
  end

  describe 'GET #show' do
    let!(:post) { create(:post) }
    context '取得に成功したとき' do
      before do
        get api_v1_post_path(1)
      end

      it 'HTTPステータスが200であること' do
        expect(response.status).to eq(200)
      end

      it 'jsonで正しい投稿が取得されること' do
        expect(json['title']).to eq 'test'
      end
    end

    context '投稿が見つからないとき' do
      it 'エラーが返されること' do
        expect do
          get api_v1_post_path(999)
        end.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'POST #create' do
    context '作成に成功したとき' do
      let(:params) do
        { title: 'test', body: 'test', prefecture: 'test', city: 'test', town: 'test', lat: 0, lng: 0 }
      end

      it 'HTTPステータスが201であること' do
        post api_v1_posts_path, params: params, headers: headers
        expect(response.status).to eq(201)
      end

      it '投稿が保存されること' do
        expect do
          post api_v1_posts_path, params: params, headers: headers
        end.to change(Post, :count).by(1)
      end
    end

    context '作成に失敗したとき' do
      let(:invalid_params) do
        { title: nil, body: 'test', prefecture: 'test', city: 'test', town: 'test', lat: 0, lng: 0 }
      end

      it 'HTTPステータスが422であること' do
        post api_v1_posts_path, params: invalid_params, headers: headers
        expect(response.status).to eq(422)
      end

      it '投稿が保存されないこと' do
        expect do
          post api_v1_posts_path, params: invalid_params, headers: headers
        end.to_not change(Post, :count)
      end
    end
  end

  describe 'PATCH #update' do
    let!(:post) { create(:post) }
    context 'パラメータが正常な場合' do
      let(:params) do
        { id: 1, title: 'test update', body: 'test', prefecture: 'test', city: 'test', town: 'test', lat: 0, lng: 0 }
      end

      it 'HTTPステータスが200であること' do
        patch api_v1_post_path(id: 1), params: params, headers: headers
        expect(response.status).to eq 200
      end

      it 'タイトルが更新されること' do
        expect do
          patch api_v1_post_path(id: 1), params: params, headers: headers
        end.to change { Post.find(1).title }.from('test').to('test update')
      end
    end

    context 'パラメータが異常な場合' do
      let(:invalid_params) do
        { id: 1, title: nil, body: 'test', prefecture: 'test', city: 'test', town: 'test', lat: 0, lng: 0 }
      end

      it 'HTTPステータスが422であること' do
        patch api_v1_post_path(id: 1), params: invalid_params, headers: headers
        expect(response.status).to eq 422
      end

      it 'タイトルが更新されないこと' do
        expect do
          patch api_v1_post_path(id: 1), params: invalid_params, headers: headers
        end.to_not change(Post.find(1), :title)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:post) { create(:post) }

    context 'パラメータが正常な場合' do
      it 'HTTPステータスが200であること' do
        delete api_v1_post_path(id: 1), headers: headers
        expect(response.status).to eq 200
      end

      it '投稿が削除されること' do
        expect do
          delete api_v1_post_path(id: 1), headers: headers
        end.to change(Post, :count).by(-1)
      end
    end

    context 'パラメータが異常な場合' do
      it '投稿が削除されること' do
        expect do
          delete api_v1_post_path(id: 999), headers: headers
        end.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end
