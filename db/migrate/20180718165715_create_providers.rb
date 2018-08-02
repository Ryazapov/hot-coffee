class CreateProviders < ActiveRecord::Migration[5.1]
  def change
    create_table(:providers) do |t|
      t.string :name, null: false
      t.string :uid, null: false

      t.belongs_to :user, null: false, foreign_key: true, index: false, on_delete: :cascade
    end

    add_index :providers, %i[uid name], unique: true
    add_index :providers, %i[user_id name], unique: true
  end
end
