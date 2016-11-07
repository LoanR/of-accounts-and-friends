class Credit < ApplicationRecord
  belongs_to :creditor, class_name: 'Friend'
  belongs_to :debtor, class_name: 'Friend'
  belongs_to :board

  validates :creditor, presence: true
  validates :debtor, presence: true
  # validates :debtor, uniqueness: :creditor
  validates :amountint, presence: true

  def amount
    dec = 0.0
    self.amountdec ? dec = self.amountdec : dec = 0.0
    dec /= 100.0
    amount = self.amountint + dec
  end

end
