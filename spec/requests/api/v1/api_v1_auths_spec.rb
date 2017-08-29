require "rails_helper"

RSpec.describe "Api::V1::Auths", type: :request do
  describe "#sign_in" do
    let(:url) { "/api/v1/signin" }
    let(:headers) { { "Content-Type" => "application/json" } }

    context "valid credentials" do
      before(:each) do
        @user = create(:user)
        params = { email: @user.email, password: @user.password }
        post url, params: { auth: params }.to_json, headers: headers
        @response = JSON.parse(response.body)
      end

      it "responds with 201" do
        expect(response).to have_http_status(201)
      end

      it "returns a json object with a jwt key" do
        expect(@response).to have_key("jwt")
      end

      it "returns jwt token that can be decoded" do
        expect(Auth.decode(@response["jwt"])).to have_key("id")
      end

      it "returns a jwt token with the correct user id" do
        expect(Auth.decode(@response["jwt"])["id"]).to eq(@user.id)
      end

      it "returns user id, email, and first_name" do
        expect(@response["id"]).to eq(@user.id)
        expect(@response["email"]).to eq(@user.email)
        expect(@response["name"]).to eq(@user.first_name)
      end
    end

    context "invalid credentials" do
      before(:each) do
        user = create(:user)
        params = { email: user.email, password: "" }
        post url, params: { auth: params }.to_json, headers: headers
      end

      it "responds with 401" do
        expect(response).to have_http_status(401)
      end
    end
  end
end
