require 'rails_helper'

RSpec.describe 'Auth', type: :request do
  describe 'ユーザーログインのテスト' do
    let!(:user) {create(:user)}

    context 'パラメータが正常な場合' do
      before do
        post api_v1_user_session_path, params: {email:user['email'], password: 'password'}
      end

      it 'HTTPステータスが200であること' do
        expect(response.status).to eq(200)
      end

      it 'レスポンスが正しいこと' do
        json = JSON.parse(response.body)
        expect(json['data']['email']).to eq(user['email'])
      end
    end

    context 'パラメータが異常な場合' do
      before do
        post api_v1_user_session_path, params: { email: user['email'], password: 'passwordxxx'}
      end

      it 'HTTPステータスが401であること' do
        expect(response.status).to eq(401)
      end

      it 'jsonがnilでかえされること' do
        json = JSON.parse(response.body)
        expect(json['user']).to eq nil
      end
    end
  end

  describe 'ユーザー登録のテスト' do
    context 'パラメータが正常な場合' do
      let(:params) {{ name: 'test', email: 'test@rspec.com', password: 'password', password_confirmation: 'password'}}
      before do
        post api_v1_user_registration_path, params: params
      end

      it 'HTTPステータスが200であること' do
        expect(response.status).to eq(200)
      end

      it 'レスポンスが正しいこと' do
        expect(JSON.parse(response.body)['status']).to eq("success")
      end
    end

    context 'パラメータが異常な場合' do
      let(:params) {{name: nil, email: 'test@it.com', password: 'password', prefecture: 14, introduction: 'testest'}}
      before do
        post api_v1_user_registration_path, params: params
      end

      it 'HTTPステータスが422であること' do
        expect(response.status).to eq(422)
      end

      it 'ユーザーが登録されないこと' do
        expect do
        end.to_not change(User, :count)
      end
    end
  end

  describe 'ユーザーログアウトのテスト' do
    context 'ユーザーがログインしているとき' do
      let(:api_v1_current_user) { create(:user) }
      let(:headers) { api_v1_current_user.create_new_auth_token }
      it 'ログアウトできる' do
        delete destroy_api_v1_user_session_path, headers: headers
        expect(response.status).to eq(200)
        expect(api_v1_current_user.reload.tokens).to be_blank
      end
    end
  end
end