class SmsController < ApplicationController
  require "twilio-ruby"

  def initialize
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

  def create
    @client.messages.create(
      from: phone_number,
      to: params[:phone_number],
      body: params[:body],
    )
  end

  def messages
    @client.messages.list(limit: 20)
  end

  def account_sid
    Rails.application.credentials.twilio[:account_sid]
  end

  def auth_token
    Rails.application.credentials.twilio[:auth_token]
  end

  def phone_number
    Rails.application.credentials.twilio[:phone_number]
  end
end
