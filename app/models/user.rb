class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  has_many :reviews
  has_many :trips
  has_many :restaurant_lookup_requests
  has_many :restaurant_lookup_responses
end
