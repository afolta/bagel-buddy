require 'rails_helper'

RSpec.describe "RestaurantLookups", type: :request do
  describe "POST /restaurants-lookup" do
    let!(:current_user_latitude) { '39.94709795'}
    let!(:current_user_longitude) { '-75.17313898856435'}
    let!(:current_user) { User.create }

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

    end

    it 'returns an HTTP status of 200' do
      post '/restaurants-lookup', params:
                          {
                            latitude: current_user_latitude,
                            longitude: current_user_longitude
                          }
      expect(response).to have_http_status(200)
    end
  end
end
