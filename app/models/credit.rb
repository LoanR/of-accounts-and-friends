class Credit < ApplicationRecord
  belongs_to :creditor, class_name: 'Friend'
  belongs_to :debtor, class_name: 'Friend'
  belongs_to :board

  validates :creditor, presence: true
  validates :debtor, presence: true
  # validates :debtor, uniqueness: :creditor
  validates_numericality_of :amountint, allow_nil: true
  validates_numericality_of :amountdec, allow_nil: true
  validates_length_of :amountdec, maximum: 2

  validate :money_or_cents

  def amount
    dec = 0.0
    self.amountdec ? dec = self.amountdec : dec = 0.0
    dec /= 100.0
    amount = self.amountint + dec
  end

  private

  def money_or_cents
    if amountint == 0 && amountdec == 0
      errors.add(:base, "The credit is missing a value")
    end
  end

end
