class CreateProviders < ActiveRecord::Migration[5.1]
  def change
    create_table(:providers) do |t|
      t.string :name, null: false
      t.string :uid, null: false

      t.belongs_to :user
    end

    add_index :providers, [:name, :uid], unique: true
    add_index :providers, [:name, :user_id], unique: true
  end
end
