class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :image_url
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
