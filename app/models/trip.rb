class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :reviews
  has_many :images, through: :review
end
