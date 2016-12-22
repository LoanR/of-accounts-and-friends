class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.references :board, foreign_key: true
      t.references :payer
      t.references :creator
      t.date :date
      t.integer :amountint
      t.integer :amountdec
      t.text :comment

      t.timestamps
    end
  end
end
