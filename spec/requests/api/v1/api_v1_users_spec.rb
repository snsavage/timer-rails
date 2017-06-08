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
      end

      it 'responds with a 201 status' do
        post url, params: {user: params}.to_json, headers: headers
        expect(response).to have_http_status(201)
      end

      context 'a jwt token is returned' do
        before(:each) do
          post url, params: {user: params}.to_json, headers: headers
          @jwt = JSON.parse(response.body)
        end

        it 'returns a json object with a jwt key' do
          expect(@jwt).to have_key('jwt')
        end

        it 'returns jwt token that can be decoded' do
          jwt = JSON.parse(response.body)
          expect(Auth.decode(@jwt['jwt'])).to have_key('id')
        end

        it 'returns a jwt token with the correct user id' do
          user = User.first
          expect(Auth.decode(@jwt['jwt'])['id']).to eq(user.id)
        end
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
end
