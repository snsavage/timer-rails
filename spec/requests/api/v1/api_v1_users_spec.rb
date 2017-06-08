require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  describe '#register' do
    let(:url) { '/api/v1/register' }
    let(:headers) {
      { 'Content-Type': 'application/json' }
    }

    context 'with valid credentials' do
      let(:params) { attributes_for(:user) }

      it 'creates a new user and responds with 201' do
        expect do
          post url, params: {user: params}.to_json, headers: headers
        end.to change{User.count}.by(1)

        expect(response).to have_http_status(201)
      end
    end

    context 'with invalid credentials' do
      let(:params) { attributes_for(:user, password_confirmation: '') }

      it 'does NOT create a new user and responds with 422' do
        expect do
          post url, params: {user: params}.to_json, headers: headers
        end.to change{User.count}.by(0)

        expect(response).to have_http_status(422)
      end
    end
  end

  describe '#sign_in' do
    let(:url) { '/api/v1/signin' }
    let(:headers) {
      { 'Content-Type': 'application/json' }
    }

    context 'valid credentials' do
      it 'responds with 201' do
        user = create(:user)
        params = {email: user.email, password: user.password}
        post url, params: {user: params}.to_json, headers: headers

        expect(response).to have_http_status(201)
      end
    end

    context 'invalid credentials' do
      it 'responds with 401' do
        user = create(:user)
        params = {email: user.email, password: ''}
        post url, params: {user: params}.to_json, headers: headers

        expect(response).to have_http_status(401)
      end
    end
  end
end
