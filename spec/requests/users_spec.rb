require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user_params) {
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

  describe "POST /users" do
    before do
      post '/users', params: user_params
      @response = response
      @response_message = JSON.parse(@response.body)
    end

    it 'returns an HTTP status of Created' do
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
end
