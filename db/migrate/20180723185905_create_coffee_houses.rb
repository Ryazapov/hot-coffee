class CreateCoffeeHouses < ActiveRecord::Migration[5.1]
  def change
    create_table :coffee_houses do |t|
      t.string :name, null: false, index: true
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.string :address, null: false
      t.string :description

      t.belongs_to :owner, null: false
    end

    add_index :coffee_houses, %i[latitude longitude]
  end
end
