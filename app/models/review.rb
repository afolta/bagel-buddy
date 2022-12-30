class Review < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  belongs_to :trip
  has_many :images, through: :restaurant
end
