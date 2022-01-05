require 'rails_helper'

RSpec.describe Api::V1::RatesController, type: :request do
  let!(:user) { create(:user) }
  let!(:new_post) { create(:post) }
  let!(:headers) { user.create_new_auth_token }
  let(:json) { JSON.parse(response.body) }

  describe 'POST #create' do
    context '作成に成功したとき' do
      let(:params) do
        { post_id: 1, rate: 3 }
      end

      it 'HTTPステータスが201であること' do
        post api_v1_rates_path, params: params, headers: headers
        expect(response.status).to eq(201)
      end

      it '投稿が保存されること' do
        expect do
          post api_v1_rates_path, params: params, headers: headers
        end.to change(Rate, :count).by(1)
      end
    end

    context '作成に失敗したとき' do
      let(:invalid_params) do
        { post_id: 1, rate: nil }
      end
      before do
      end

      it 'HTTPステータスが422であること' do
        post api_v1_rates_path, params: invalid_params, headers: headers
        expect(response.status).to eq(422)
      end

      it '投稿が保存されないこと' do
        expect do
          post api_v1_posts_path, params: invalid_params, headers: headers
        end.to_not change(Rate, :count)
      end
    end
  end

  describe 'PATCH #update' do
    let!(:rate) { create(:rate) }
    context 'パラメータが正常な場合' do
      let(:params) do
        { post_id: 1, rate: 2 }
      end

      it 'HTTPステータスが200であること' do
        patch api_v1_rate_path(id: 1), params: params, headers: headers
        expect(response.status).to eq(200)
      end

      it '点数が更新されること' do
        expect do
          patch api_v1_rate_path(id: 1), params: params, headers: headers
        end.to change { Rate.find(1).rate }.from(3).to(2)
      end
    end

    context '編集に失敗したとき' do
      let(:invalid_params) do
        { post_id: 1, rate: nil }
      end

      it 'HTTPステータスが422であること' do
        patch api_v1_rate_path(id: 1), params: invalid_params, headers: headers
        expect(response.status).to eq(422)
      end

      it '点数が更新されないこと' do
        expect do
          patch api_v1_rate_path(id: 1), params: invalid_params, headers: headers
        end.to_not change(Rate.find(1), :rate)
      end
    end
  end
end
