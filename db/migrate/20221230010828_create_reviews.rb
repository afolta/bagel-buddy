class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :restaurant_id
      t.integer :trip_id
      t.string :description
      t.integer :rating
      t.integer :user_id

      t.timestamps
    end
  end
end
