class RestaurantLookupResponse < ApplicationRecord
  has_one :restaurant_lookup_request
  # has_many :restaurants
end
