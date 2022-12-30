# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!(name: "test person", email: "test@test.com", password_digest: "password", image_url: "image")

Restaurant.create!(name: "Philly Style Bagels Old City", latitude: "39.948416", longitude: "-75.147291")

Trip.create!(user_id: 1, restaurant_id: 1)

Image.create!(image_url: "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fshmagelsbagels.com%2Fwp-content%2Fuploads%2F2019%2F03%2Fhistory-of-the-bagel.jpg&f=1&nofb=1&ipt=ff7bbd5a0d05e03e4656da1a73065f7dec6557b9f27bce4a362be037df600aa8&ipo=images", restaurant_id: 1)

Review.create!(restaurant_id: 1, trip_id: 1, description: "The salmon flavored cream cheese tasted like it was a year old.", rating: 1, user_id: 1)
