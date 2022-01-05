require 'rails_helper'

RSpec.describe 'Label', type: :request do
  let!(:user) { create(:user) }
  let!(:new_post) { create(:post) }
  let!(:headers) { user.create_new_auth_token }
  let(:json) { JSON.parse(response.body) }

  describe 'ラベルを新規作成する' do
     context '作成に成功したとき' do
      let(:params) do
        { post_id: 1, name: 'test' }
      end

      it 'HTTPステータスが201であること' do
        post api_v1_labels_path, params: params, headers: headers
        expect(response.status).to eq(201)
      end

      it '投稿が保存されること' do
        expect do
          post api_v1_labels_path, params: params, headers: headers
        end.to change(Label, :count).by(1)
      end
    end
  end

  describe 'ラベルを削除する' do
    
  end
end