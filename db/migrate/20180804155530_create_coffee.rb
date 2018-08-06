class CreateCoffee < ActiveRecord::Migration[5.1]
  def change
    create_table :coffees do |t|
      t.string :name, null: false
      t.string :kind, null: false
      t.integer :volume, null: false
      t.decimal :price, null: false, precision: 10, scale: 2
      t.string :description

      t.belongs_to :coffee_house, null: false, foreign_key: true, index: true, on_delete: :cascade

      t.timestamps
    end
  end
end
