require 'rails_helper'

RSpec.describe "Api::V1::Routines", type: :request do
  describe '#index' do
    let(:url) { '/api/v1/routines' }

    context 'with a user returns a json formated list of routines' do
      before(:each) {
        user = create(:user)
        headers = auth_headers(user)
        routines = create_list(:routine, 2, user_id: user.id)
        get url, params: {}, headers: headers
      }

      it { expect(response.content_type).to eq("application/json") }
      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to match_response_schema("routines") }
    end
  end
end
