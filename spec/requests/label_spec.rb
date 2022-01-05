require 'rails_helper'

RSpec.describe Api::V1::LabelsController, type: :request do
  let!(:user) { create(:user) }
  let!(:new_post) { create(:post) }
  let!(:headers) { user.create_new_auth_token }
  let(:json) { JSON.parse(response.body) }

  describe 'POST #create' do
    context '作成に成功したとき' do
      let(:params) do
        { post_id: 1, name: 'test' }
      end

      it 'HTTPステータスが201であること' do
        post api_v1_labels_path, params: params, headers: headers
        expect(response.status).to eq(201)
      end

      it 'ラベルが保存されること' do
        expect do
          post api_v1_labels_path, params: params, headers: headers
        end.to change(Label, :count).by(1)
      end
    end

    context '作成に失敗したとき' do
      let(:invalid_params) do
        { post_id: 1, name: nil }
      end

      it 'HTTPステータスが422であること' do
        post api_v1_labels_path, params: invalid_params, headers: headers
        expect(response.status).to eq(422)
      end

      it 'ラベルが保存されないこと' do
        expect do
          post api_v1_labels_path, params: invalid_params, headers: headers
        end.to_not change(Label, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:label) { create(:label) }

    context 'パラメータが正常な場合' do
      it 'HTTPステータスが200であること' do
        delete api_v1_label_path(id: 1), headers: headers
        expect(response.status).to eq 200
      end

      it 'ラベルが削除されること' do
        expect do
          delete api_v1_label_path(id: 1), headers: headers
        end.to change(Label, :count).by(-1)
      end
    end

    context 'パラメータが異常な場合' do
      it 'エラーが返されること' do
        expect do
          delete api_v1_label_path(id: 999), headers: headers
        end.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end
