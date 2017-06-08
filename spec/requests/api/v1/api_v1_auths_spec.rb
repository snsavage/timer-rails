require 'rails_helper'

RSpec.describe "Api::V1::Auths", type: :request do
  describe '#sign_in' do
    let(:url) { '/api/v1/signin' }
    let(:headers) {
      { 'Content-Type': 'application/json' }
    }

    context 'valid credentials' do
      it 'responds with 201' do
        user = create(:user)
        params = {email: user.email, password: user.password}
        post url, params: {auth: params}.to_json, headers: headers

        expect(response).to have_http_status(201)
      end
    end

    context 'invalid credentials' do
      it 'responds with 401' do
        user = create(:user)
        params = {email: user.email, password: ''}
        post url, params: {auth: params}.to_json, headers: headers

        expect(response).to have_http_status(401)
      end
    end
  end
end
