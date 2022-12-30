Rails.application.routes.draw do
  post "/users" => "users#create"

  post "/sessions" => "sessions#create"

  get "/restaurants" => "restaurants#index"

  get "/reviews" => "reviews#index"

  get "/trips/:id" => "trips#show"
  post "/trips" => "trips#create"
end
