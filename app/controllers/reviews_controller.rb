class ReviewsController < ApplicationController
  def index
    reviews = Review.all
    render json: reviews.as_json
  end
end
