class CreateUserAccountLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :user_account_links do |t|
      t.references :user, foreign_key: true
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
