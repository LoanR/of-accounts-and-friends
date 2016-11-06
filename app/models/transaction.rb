class Transaction < ApplicationRecord
  belongs_to :payer, class_name: 'Friend'
  belongs_to :board

  validates :payer, presence: true
  validates :amountint, presence: true
  validates :date, presence: true

  def amount
    dec = 0.0
    self.amountdec ? dec = self.amountdec : dec = 0.0
    dec /= 100.0
    amount = self.amountint + dec
  end

end
