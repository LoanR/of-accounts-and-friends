class Friend < ApplicationRecord
  belongs_to :board
  has_many :transactions, foreign_key: :payer_id
  has_many :credits, foreign_key: :creditor_id
  has_many :credits, foreign_key: :debtor_id

  validates :name, presence: true

end
