class Restaurant < ApplicationRecord
  has_many :reviews
  has_many :trips
  has_many :images
end
