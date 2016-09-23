class CreateFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends do |t|
      t.references :account, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
