require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  describe '#register' do
    # it 'has a #register route and action' do
    #   should route(:post, '/api/v1/register').to(format: :json, action: :register)
    # end

    let(:url) { '/api/v1/register' }
    let(:headers) {
      { 'Content-Type': 'application/json' }
    }

    context 'with valid credentials' do
      let(:params) { attributes_for(:user) }

      it 'creates a new user' do
        expect do
          post url, params: {user: params}.to_json, headers: headers
        end.to change{User.count}.by(1)
      end

      it 'has a response code of 201' do
        post url, params: {user: params}.to_json, headers: headers
        expect(response).to have_http_status(201)
      end
    end

    context 'with invalid credentials' do
      let(:params) { attributes_for(:user, password_confirmation: '') }

      it 'does NOT create a new user' do
        expect do
          post url, params: {user: params}.to_json, headers: headers
        end.to change{User.count}.by(0)
      end

      it 'has a 422 response code' do
        post url, params: {user: params}.to_json, headers: headers
        expect(response).to have_http_status(422)
      end
    end

  end

end
