require "rails_helper"

RSpec.describe "Api::V1::Routines", type: :request do
  describe "#index" do
    let(:url) { "/api/v1/routines" }

    context "with a user returns a json formated list of routines" do
      before(:each) do
        @user = create(:user)
        headers = auth_headers(@user)

        create_list(:routine, 2, user_id: @user.id)
        create_list(:routine, 2)

        get url, params: {}, headers: headers
      end

      it { expect(response.content_type).to eq("application/json") }
      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to match_response_schema("routines") }

      it "returns only routines belonging to the user" do
        routine_ids = @user.routines.pluck(:id)
        response_ids = json[:routines].map { |x| x[:id] }

        expect(response_ids).to eq(routine_ids)
      end

      it "does not return routines not belonging to the user" do
        routine_ids = Routine.where.not(user_id: @user.id).pluck(:id)
        response_ids = json[:routines].map { |x| x[:id] }

        expect(response_ids).to_not eq(routine_ids)
      end
    end

    context "with public routines" do
      before(:each) do
        @user = create(:user)
        headers = auth_headers(@user)

        create_list(:routine, 2, user_id: @user.id)
        create_list(:routine, 2)
        create_list(:routine, 2, public: true)

        get url, params: {}, headers: headers
      end

      it "returns also returns public routines" do
        routine_ids = @user.routines.pluck(:id)
        public_ids = Routine.where(public: true).pluck(:id)

        response_ids = json[:routines].map { |x| x[:id] }

        expect(response_ids).to match_array(routine_ids + public_ids)
      end
    end

    context "without a user" do
      before(:each) do
        @private_ids = create_list(:routine, 1).pluck(:id)
        @public_ids = create_list(:routine, 2, public: true).pluck(:id)

        get url, params: {}, headers: bad_auth_headers
      end

      it "should not return 401" do
        expect(response.status).not_to eq(401)
      end

      it "only returns public routines" do
        response_ids = json[:routines].map { |x| x[:id] }

        expect(response_ids).to match_array(@public_ids)
        expect(response_ids).to_not match_array(@private_ids)
      end
    end
  end

  describe "#show" do
    let(:url) { "/api/v1/routines" }

    context "with a valid user" do
      before(:each) do
        @user = create(:user)
        headers = auth_headers(@user)

        routine = create(:routine, user_id: @user.id)
        create(:routine)

        get "#{url}/#{routine.id}", params: {}, headers: headers
      end

      it { expect(response.content_type).to eq("application/json") }
      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to match_response_schema("routine") }
      it { expect(json[:routine][:user_id]).to eq(@user.id) }
    end

    it "does not show private routines form other users" do
      @user = create(:user)
      headers = auth_headers(@user)

      create(:routine, user_id: @user.id)
      private_routine = create(:routine)

      get "#{url}/#{private_routine.id}", params: {}, headers: headers

      expect(response.status).to eq(403)
    end

    it "does show public routines from other users" do
      @user = create(:user)
      headers = auth_headers(@user)

      create(:routine, user_id: @user.id)
      private_routine = create(:routine, public: true)

      get "#{url}/#{private_routine.id}", params: {}, headers: headers

      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(:ok)
      expect(response).to match_response_schema("routine")
    end
  end

  describe "#create" do
    let(:url) { "/api/v1/routines" }

    describe "with a valid user" do
      before(:each) do
        @user = create(:user)
        @headers = auth_headers(@user)
      end

      it "creates a routine with no groups or intervals" do
        routine = attributes_for(:routine)

        expect do
          post url.to_s, params: { routine: routine }.to_json, headers: @headers
        end.to change { Routine.count }.by 1
        expect(response.status).to eq(201)
      end

      it "creates a routine with groups" do
        routine = attributes_for(:routine)
        group = attributes_for(:group)

        params = {
          routine: routine.merge(groups_attributes: [group, group])
        }

        post url.to_s, params: params.to_json, headers: @headers

        expect(response.status).to eq(201)
        expect(Routine.count).to eq 1
        expect(Routine.first.groups.count).to eq 2
      end

      it "create a routine with groups and intervals" do
        routine = attributes_for(:routine)
        group = attributes_for(:group)
        interval = attributes_for(:interval)

        group_params = group.merge(intervals_attributes: [interval, interval])

        params = {
          routine: routine.merge(
            groups_attributes: [group_params, group_params]
          )
        }

        post url.to_s, params: params.to_json, headers: @headers

        expect(response.status).to eq(201)
        expect(Routine.count).to eq 1
        expect(Routine.first.groups.count).to eq 2
        expect(Routine.first.groups.first.intervals.count).to eq 2
        expect(Routine.first.groups.second.intervals.count).to eq 2
      end

      describe "with invalid input" do
        it "returns a with a 400 status code" do
          params = { routine: { name: "" } }

          post url.to_s, params: params.to_json, headers: @headers

          expect(response.status).to eq(400)
        end
      end
    end

    describe "without a user" do
      it "requires an authenticated user" do
        routine = attributes_for(:routine)

        post url.to_s, params: { routine: routine }.to_json, headers: headers
        expect(response.status).to eq(401)
      end
    end
  end

  describe "#update" do
    let(:url) { '/api/v1/routines' }

    describe "with a valid user" do
      before(:each) do
        @user = create(:user)
        @headers = auth_headers(@user)
      end

      it "updates a routine with no groups or intervals" do
        routine = create(:routine, user: @user)
        routine.name = "New Name"

        patch "#{url}/#{routine.id}",
              params: { routine: routine }.to_json,
              headers: @headers

        expect(response.status).to eq(202)
        expect(Routine.find(routine.id).name).to eq("New Name")
      end

      it "updates a routine with groups" do
        routine = create(:routine, user: @user)
        create_list(:group, 1, routine: routine)

        params = serialize(routine)
        params[:routine][:groups][0][:times] = 2
        params[:routine].merge!({ groups_attributes: params[:routine][:groups] })

        patch "#{url}/#{routine.id}", params: params.to_json, headers: @headers

        expect(response.status).to eq(202)
        expect(Routine.count).to eq 1
        expect(Routine.first.groups.count).to eq 1
        expect(Routine.first.groups.first.times).to eq 2
      end

      it "removes groups from routine" do
        routine = create(:routine, user: @user)
        groups = create_list(:group, 2, routine: routine)

        params = serialize(routine)
        params[:routine].merge!({
          groups_attributes: [params[:routine][:groups][0]]
        })

        patch "#{url}/#{routine.id}", params: params.to_json, headers: @headers

        expect(response.status).to eq(202)
        expect(Routine.count).to eq 1
        expect(Routine.first.groups.count).to eq 1
        expect(Routine.first.groups.last.id).not_to eq groups.last.id
      end

      it "updates a routine with groups and intervals" do
        routine = create(:routine, user: @user)
        group = create(:group, routine: routine)
        interval = create(:interval, group: group)

        options = { include: ['groups.intervals'] }
        params = serialize(Routine.first, options)
        params[:routine][:groups][0][:intervals][0][:name] = "Changed"

        params.deep_transform_keys! do |key|
          key = :groups_attributes if key == :groups
          key = :intervals_attributes if key == :intervals
          key
        end

        patch "#{url}/#{routine.id}", params: params.to_json, headers: @headers

        expect(response.status).to eq(202)
        expect(Routine.count).to eq 1
        expect(Routine.first.groups.count).to eq 1
        expect(Routine.first.groups.first.intervals.count).to eq 1
        expect(Routine.first.groups.first.intervals.first.name).to eq "Changed"
      end

      it "remove intervals from routine groups" do
        routine = create(:routine, user: @user)
        group = create(:group, routine: routine)
        intervals = create_list(:interval, 2, group: group)

        options = { include: ['groups.intervals'] }
        params = serialize(Routine.first, options)
        params[:routine][:groups][0][:intervals] = [
          params[:routine][:groups][0][:intervals][0]
        ]

        params.deep_transform_keys! do |key|
          key = :groups_attributes if key == :groups
          key = :intervals_attributes if key == :intervals
          key
        end

        patch "#{url}/#{routine.id}", params: params.to_json, headers: @headers

        expect(response.status).to eq(202)
        expect(Routine.count).to eq 1
        expect(Routine.first.groups.count).to eq 1
        expect(Routine.first.groups.first.intervals.count).to eq 1
      end
    end

    describe "with an invalid user" do
      it "requires an authenticated user" do
        routine = create(:routine)

        patch "#{url}/#{routine.id}",
          params: serialize(routine).to_json, headers: headers

        expect(response.status).to eq(401)
      end

      it "requires an authorized user" do
        user = create(:user)
        headers = auth_headers(user)

        routine = create(:routine)

        patch "#{url}/#{routine.id}",
          params: serialize(routine).to_json, headers: headers

        expect(response.status).to eq(403)
      end
    end
  end
end
