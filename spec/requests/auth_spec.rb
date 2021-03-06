require 'rails_helper'

RSpec.describe Api::V1::Auth::RegistrationsController, type: :request do
  let(:json) { JSON.parse(response.body) }
  describe 'ユーザーログインのテスト' do
    let!(:user) { create(:user) }
    context 'パラメータが正常な場合' do
      before do
        post api_v1_user_session_path, params: { email: user['email'], password: 'password' }
      end

      it 'HTTPステータスが200であること' do
        expect(response.status).to eq(200)
      end

      it 'レスポンスが正しいこと' do
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
        expect(json['user']).to eq nil
      end
    end
  end

  describe 'ユーザー新規登録のテスト' do
    context 'パラメータが正常な場合' do
      let(:params) do
        { name: 'test', prefecture: 3, email: 'testest@testtest.com', password: 'aaaaaa', password_confirmation: 'aaaaaa' }
      end

      it 'HTTPステータスが200であること' do
        post api_v1_user_registration_path, params: params
        expect(response.status).to eq(200)
      end

      it 'レスポンスのjsonが正しいこと' do
        post api_v1_user_registration_path, params: params
        expect(json['data']['name']).to eq 'test'
      end
    end

    context 'パラメータが異常な場合' do
      let(:params) do
        { name: nil, email: 'test@it.com', password: 'password', prefecture: 14, introduction: 'testest' }
      end

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
      let!(:api_v1_current_user) { create(:user) }
      let(:headers) { api_v1_current_user.create_new_auth_token }
      it 'ログアウトできる' do
        delete destroy_api_v1_user_session_path, headers: headers
        expect(response.status).to eq(200)
        expect(api_v1_current_user.reload.tokens).to be_blank
      end
    end
  end

  describe 'ログイン中のユーザーのデータ取得テスト' do
    context 'ユーザーがログインしているとき' do
      let!(:api_v1_current_user) { create(:user) }
      let(:headers) { api_v1_current_user.create_new_auth_token }
      context '取得に成功したとき' do
        before do
          get api_v1_auth_sessions_path, headers: headers
        end

        it 'HTTPステータスが200であること' do
          expect(response.status).to eq(200)
        end

        it 'jsonで正しい投稿が取得されること' do
          expect(json['name']).to eq 'rspec-user'
        end
      end

      context '取得に失敗したとき' do
        before do
          get api_v1_auth_sessions_path
        end

        it 'HTTPステータスが422であること' do
          expect(response.status).to eq(422)
        end

        it 'jsonがnilでかえされること' do
          expect(json['name']).to eq nil
        end
      end
    end
  end
end
