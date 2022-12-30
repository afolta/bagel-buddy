class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.integer :user_id
      t.integer :restaurant_id

      t.timestamps
    end
  end
end
