Rails.application.routes.draw do
  post "/users" => "users#create"
  patch "/users/:id" => "users#update"
  get "/users/:id" => "users#show"

  post "/sessions" => "sessions#create"

  get "/restaurants" => "restaurants#index"

  get "/reviews" => "reviews#index"
  post "/reviews" => "reviews#new"

  get "/trips" => "trips#index"
  get "/trips/:id" => "trips#show"
  post "/trips" => "trips#create"

  post "/restaurants-lookup" => "restaurants_lookup#new"
end
