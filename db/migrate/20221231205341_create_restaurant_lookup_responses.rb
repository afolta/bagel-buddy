class CreateRestaurantLookupResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurant_lookup_responses do |t|
      t.string :lookupResponse
      t.integer :restaurant_lookup_request_id

      t.timestamps
    end
  end
end
