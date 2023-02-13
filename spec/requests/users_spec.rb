require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:valid_user_params) {
      { 'name' => 'Test Person',
        'email' => 'testperson@test.com',
        'password' => 'password',
        'password_confirmation' => 'password',
        'address' => '864 Rose St',
        'city' => 'West Lafayette',
        'state' => 'IN',
        'zip' => '47906'
      }
  }
  let(:invalid_user_params) {
      { 'name' => 'Test Person',
        'email' => 'testperson@test.com',
        'password' => 'password',
        'password_confirmation' => 'password',
        'address' => '',
        'city' => '',
        'state' => '',
        'zip' => ''
      }
  }
  let!(:user) { User.create(
                         name: "Test Person",
                         email: "testperson2@test.com",
                         password: "password",
                         password_confirmation: "password",
                         address: "864 Rose St",
                         city: "West Lafayette",
                         state: "IN",
                         zip: "47906",
                         latitude: "39.94709795",
                         longitude: "-75.17313898856435") }

  describe "POST /users with valid parameters" do
    before do
      post '/users', params: valid_user_params
      @response = response
      @response_message = JSON.parse(@response.body)
    end

    it 'returns an HTTP status of created' do
      expect(@response).to have_http_status(201)
    end

    it 'returns a message that the user was created' do
      expect(@response_message).to include("message" => "User created successfully")
    end

    it 'sets the users coordinates' do
      expect(User.last.latitude).to eq("40.434603894154144")
      expect(User.last.longitude).to eq("-86.90127979182287")
    end
  end

  describe "POST /users with invalid parameters" do
    before do
      post '/users', params: invalid_user_params
      @response = response
      @response_message = JSON.parse(@response.body)
    end

    it 'returns an HTTP status of Unprocessable Entity' do
      expect(@response).to have_http_status(400)
    end

    it 'returns a message that the user was created' do
      expect(@response_message).to include({ "message" => "Invalid address search" })
    end
  end

  describe "PATCH /users/:id with valid parameters" do
    before do
      patch "/users/#{user.id}", params: { address: "326 S 19th St", city: "Philadelphia", state: "PA", zip: "19103" }
      @response = response
      @response_message = JSON.parse(@response.body)
    end

    it 'returns an HTTP status of success' do
      expect(@response).to have_http_status(200)
    end

    it 'returns a message that the user was updated' do
      expect(@response_message).to include({"message"=>"User coordinates updated successfully"})
    end
  end
end
