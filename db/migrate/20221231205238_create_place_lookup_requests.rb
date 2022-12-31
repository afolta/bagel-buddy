class CreateRestaurantLookupRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurant_lookup_requests do |t|
      t.string :lookupParameters

      t.timestamps
    end
  end
end
