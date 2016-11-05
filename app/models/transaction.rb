class Transaction < ApplicationRecord
  belongs_to :board
  # belongs_to :payer, through: :board, source: :friends

  # validates :payer, presence: true
  validates :amountint, presence: true

  def amount
    dec = 0.0
    self.amountdec ? dec = self.amountdec : dec = 0.0
    dec /= 100.0
    amount = self.amountint + dec
  end

end
