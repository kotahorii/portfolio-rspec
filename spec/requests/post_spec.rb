require 'rails_helper'

RSpec.describe 'Post', type: :request do
  let!(:user) { create(:user) }
  let!(:headers) { user.create_new_auth_token }
  let(:json) {JSON.parse(response.body)}

  describe '全投稿の取得' do
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

  describe '投稿を一つ取得する' do
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

  describe '投稿を作成する' do
    context '作成に成功したとき' do
      let(:params) do
        { title: 'test', body: 'test', prefecture: 'test', city: 'test', town: 'test', lat: 0, lng: 0 }
      end
      before do
        post api_v1_posts_path, params: params, headers: headers
      end

      it 'HTTPステータスが201であること' do
        expect(response.status).to eq(201)
      end

      it '投稿が保存されること' do
        expect do
          post api_v1_posts_path, params: params, headers: headers
        end.to change(Post, :count).by(1)
      end
    end

    context '作成に失敗したとき' do
      let(:params) do
        { title: nil, body: 'test', prefecture: 'test', city: 'test', town: 'test', lat: 0, lng: 0 }
      end
      before do
        post api_v1_posts_path, params: params, headers: headers
      end

      it 'HTTPステータスが401であること' do
        expect(response.status).to eq(401)
      end

      it '投稿が保存されること' do
        expect do
          post api_v1_posts_path, params: params, headers: headers
        end.to_not change(Post, :count)
      end
    end
  end

  describe '投稿を編集する' do
    
  end

  describe '投稿を削除する' do
    
  end
end
