class RestaurantLookupRequest < ApplicationRecord
  has_one :restaurant_lookup_response
  has_one :user
end
