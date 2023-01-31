require 'rails_helper'

RSpec.describe "RestaurantLookups", type: :request do
  describe "POST /restaurants-lookup" do
    let!(:current_user_latitude) { "39.94709795"}
    let!(:current_user_longitude) { "-75.17313898856435"}

    # it 'A user must have a zip code' do
    #   expect { User.create!(
    #                                     name: "Test Person",
    #                                     email: "testperson@test.com",
    #                                     password: "password",
    #                                     password_confirmation: "password",
    #                                     address: "864 Rose St",
    #                                     city: "West Lafayette",
    #                                     state: "IN",
    #                                     # zip: "47906",
    #                                     latitude: current_user_latitude,
    #                                     longitude: current_user_longitude
    #                                   ) }.to raise_error(ActiveRecord::RecordInvalid)
    # end

    before do
      # post '/sessions.json',
      # params: { email: "test@test.com", password: "password" }

      # jwt = response.body('jwt')

      post '/restaurants-lookup', params: {
        latitude: current_user_latitude,
        longitude: current_user_longitude
      },
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NzUyNzI1NjV9.FAcB9th3RBg6tQeruUWTrOy0ywBIRJBwuc9ixw_Ti_E',
        'Content-Type': 'application/json'
      }
    end

    it 'returns an HTTP status of 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns a name' do
      json_response = JSON.parse(response.body)

      json_response.first.dig('name').should_not be_nil
    end
  end
end