class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.references :board, foreign_key: true
      t.date :date
      t.float :amount
      t.string :creditor
      t.text :comment

      t.timestamps
    end
  end
end
