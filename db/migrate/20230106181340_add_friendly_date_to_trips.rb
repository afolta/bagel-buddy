class AddFriendlyDateToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :friendly_date, :string
  end
end
