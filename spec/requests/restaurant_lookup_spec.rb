require 'rails_helper'

RSpec.describe "RestaurantLookups", type: :request do
  describe "POST /restaurants-lookup" do
    let!(:current_user_latitude) { "39.94709795"}
    let!(:current_user_longitude) { "-75.17313898856435"}

    before do
      user = User.create(
                          name: "Test Person",
                          email: "testperson@test.com",
                          password: "password",
                          password_confirmation: "password",
                          address: "864 Rose St",
                          city: "West Lafayette",
                          state: "IN",
                          zip: "47906",
                          latitude: current_user_latitude,
                          longitude: current_user_longitude)

      jwt = JWT.encode({ user_id: user.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")

      post '/restaurants-lookup', params: {
        latitude: current_user_latitude,
        longitude: current_user_longitude
      },
       headers: { "Authorization" => "Bearer #{jwt}" }
       @response = response
    end

    it 'returns an HTTP status of 200' do
      expect(@response).to have_http_status(200)
    end

    it 'returns a name' do
      json_response = JSON.parse(@response.body)

      json_response.first.dig('name').should_not be_nil
    end
  end
end
