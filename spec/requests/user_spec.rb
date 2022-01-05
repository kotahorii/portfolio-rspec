require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let!(:headers) { user.create_new_auth_token }
  let(:json) { JSON.parse(response.body) }
  let!(:user) { create(:user) }

  describe 'GET #index' do
    context '取得に成功したとき' do
      before do
        get api_v1_users_path, headers: headers
      end

      it 'HTTPステータスが200であること' do
        expect(response.status).to eq(200)
      end

      it 'jsonで正しい投稿が取得されること' do
        expect(json[0]['name']).to eq 'rspec-user'
      end
    end
  end

  describe 'PATCH #update' do
    context 'パラメータが正常な場合' do
      let(:params) do
        { id: 1, name: 'name update', introduction:'introduction update', prefecture: 2, lat: 0, lng: 0 }
      end

      it 'HTTPステータスが200であること' do
        patch api_v1_user_path(id: 1), params: params, headers: headers
        expect(response.status).to eq 200
      end

      it '名前が更新されること' do
        expect do
          patch api_v1_user_path(id: 1), params: params, headers: headers
        end.to change { User.find(1).name }.from('rspec-user').to('name update')
      end
    end

    context 'パラメータが異常な場合' do
      let(:invalid_params) do
        { id: 1, name: nil, introduction: 'introduction update', prefecture: 2, lat: 0, lng: 0 }
      end

      it 'HTTPステータスが422であること' do
        patch api_v1_user_path(id: 1), params: invalid_params, headers: headers
        expect(response.status).to eq 422
      end

      it '名前が更新されないこと' do
        expect do
          patch api_v1_user_path(id: 1), params: invalid_params, headers: headers
        end.to_not change(User.find(1), :name)
      end
    end
  end
end
