class Transaction < ApplicationRecord
  belongs_to :payer, class_name: 'Friend'
  belongs_to :board

  validates :payer, presence: true
  validates_numericality_of :amountint, allow_nil: true
  validates_numericality_of :amountdec, allow_nil: true
  validates_length_of :amountdec, maximum: 2

  validate :money_or_cents

  # validates :date, presence: true

  def amount
    dec = 0.0
    self.amountdec ? dec = self.amountdec : dec = 0.0
    dec /= 100.0
    amount = self.amountint + dec
  end

  def div_class
    c = ''
    if self.date
      c = self.date.year.to_s + self.date.month.to_s + self.date.day.to_s
    end
    c
  end

  private

  def money_or_cents
    if amountint == 0 && amountdec == 0
      errors.add(:base, "The transaction is missing a value")
    end
  end

end
