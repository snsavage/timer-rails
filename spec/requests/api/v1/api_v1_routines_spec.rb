require 'rails_helper'

RSpec.describe "Api::V1::Routines", type: :request do
  describe '#index' do
    let(:url) { '/api/v1/routines' }
    let(:headers) {
      { 'Content-Type': 'application/json' }
    }

    context 'returns a json formated list of routines' do
      before(:each) {
        routines = create_list(:routine, 2)
        get url, params: {}, headers: headers
      }

      it { expect(response.content_type).to eq("application/json") }
      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to match_response_schema("routines") }
    end
  end
end
