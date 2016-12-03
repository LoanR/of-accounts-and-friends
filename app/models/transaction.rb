class Transaction < ApplicationRecord
  belongs_to :payer, class_name: 'Friend'
  belongs_to :board

  validates :payer, presence: true
  validates_numericality_of :amountint, allow_nil: true
  validates_numericality_of :amountdec, allow_nil: true
  validates_length_of :amountdec, maximum: 2

  validate :money_or_cents
  validate :positive_transaction

  # validates :date, presence: true

  def amount
    dec = 0.0
    self.amountdec ? dec = self.amountdec : dec = 0.0
    dec /= 100.0
    amount = self.amountint + dec
  end

  # def div_data_sort
  #   c = ''
  #   if self.date
  #     c = self.date.year.to_s + self.date.month.to_s + self.date.day.to_s
  #   end
  #   c
  # end

  def get_transaction_year
    self.date ? self.date.year : 9999
  end

  def get_transaction_month
    self.date ? self.date.month : 12
  end

  def get_transaction_day
    self.date ? self.date.day : 31
  end

  private

  def money_or_cents
    if amountint == 0 && amountdec == 0
      errors.add(:base, "The transaction is missing a value")
    end
  end

  def positive_transaction
    if amountint < 0 || amountdec < 0
      errors.add(:base, "The transaction cannot be negative")
    end
  end

end
