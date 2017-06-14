require 'rails_helper'

RSpec.describe "Api::V1::Routines", type: :request do
  describe '#index' do
    let(:url) { '/api/v1/routines' }

    context 'with a user returns a json formated list of routines' do
      before(:each) {
        @user = create(:user)
        headers = auth_headers(@user)
        routines = create_list(:routine, 2, user_id: @user.id)
        no_auth = create_list(:routine, 2)
        get url, params: {}, headers: headers
      }

      it { expect(response.content_type).to eq("application/json") }
      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to match_response_schema("routines") }

      it 'returns only routines belonging to the user' do
        routine_ids = @user.routines.pluck(:id)
        response_ids = json[:routines].map{|x| x[:id]}

        expect(response_ids).to eq(routine_ids)
      end

      it 'does not return routines not belonging to the user' do
        routine_ids = Routine.where.not(user_id: @user.id).pluck(:id)
        response_ids = json[:routines].map{|x| x[:id]}

        expect(response_ids).to_not eq(routine_ids)
      end
    end
  end
end
