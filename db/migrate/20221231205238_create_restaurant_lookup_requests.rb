class CreateRestaurantLookupRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurant_lookup_requests do |t|
      t.string :lookup_parameters

      t.timestamps
    end
  end
end
