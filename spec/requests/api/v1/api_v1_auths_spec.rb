require 'rails_helper'

RSpec.describe "Api::V1::Auths", type: :request do
  describe '#sign_in' do
    let(:url) { '/api/v1/signin' }
    let(:headers) {
      { 'Content-Type': 'application/json' }
    }

    context 'valid credentials' do
      before(:each) do
        @user = create(:user)
        params = {email: @user.email, password: @user.password}
        post url, params: {auth: params}.to_json, headers: headers
        @jwt = JSON.parse(response.body)
      end

      it 'responds with 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns a json object with a jwt key' do
        expect(@jwt).to have_key('jwt')
      end

      it 'returns jwt token that can be decoded' do
        expect(Auth.decode(@jwt['jwt'])).to have_key('id')
      end

      it 'returns a jwt token with the correct user id' do
        expect(Auth.decode(@jwt['jwt'])['id']).to eq(@user.id)
      end
    end

    context 'invalid credentials' do
      before(:each) do
        user = create(:user)
        params = {email: user.email, password: ''}
        post url, params: {auth: params}.to_json, headers: headers
      end

      it 'responds with 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
