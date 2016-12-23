class Credit < ApplicationRecord
  belongs_to :creditor, class_name: 'Friend'
  belongs_to :debtor, class_name: 'Friend'
  belongs_to :creator, class_name: 'User'
  belongs_to :board

  validates :creditor, presence: true
  validates :debtor, presence: true
  # validates :debtor, uniqueness: :creditor
  validates_numericality_of :amountint, allow_nil: true
  validates_numericality_of :amountdec, allow_nil: true
  validates_length_of :amountdec, maximum: 2

  validate :money_or_cents
  validate :positive_credit


  def amount
    total_amount_str = sprintf "%02d", (self.amountint * 100 + self.amountdec)
    int = total_amount_str.split(/\d{2}\z/).join.reverse.gsub(/(\d{3})(?=.)/, '\1 \2').reverse
    int = int == '' ? '0' : int
    dec = total_amount_str.split(//).last(2).join
    return int, dec
    # dec = 0.0
    # self.amountdec ? dec = self.amountdec : dec = 0.0
    # dec /= 100.0
    # amount = self.amountint + dec
  end

  def get_credit_year
    self.date ? self.date.year : 9999
  end

  def get_credit_month
    self.date ? self.date.month : 12
  end

  def get_credit_day
    self.date ? self.date.day : 31
  end

  private

  def money_or_cents
    if amountint == 0 && amountdec == 0
      errors.add(:base, "The credit is missing a value")
    end
  end

  def positive_credit
    if amountint < 0 || amountdec < 0
      errors.add(:base, "The transaction cannot be negative")
    end
  end

end
