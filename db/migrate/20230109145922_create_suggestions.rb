class CreateSuggestions < ActiveRecord::Migration[7.0]
  def change
    create_table :suggestions do |t|
      t.string :body
      t.integer :user_id

      t.timestamps
    end
  end
end
