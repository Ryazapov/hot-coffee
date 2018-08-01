class CreateProviders < ActiveRecord::Migration[5.1]
  def change
    create_table(:providers) do |t|
      t.string :name, null: false
      t.string :uid, null: false

      t.belongs_to :user
    end

    add_index :providers, %i[uid name], unique: true
    add_index :providers, %i[user_id name], unique: true
  end
end
