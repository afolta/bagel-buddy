class AddPlaceIdToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :place_id, :string
  end
end
