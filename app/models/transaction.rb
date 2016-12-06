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

  def get_friends_id
    friends = []
    Board.find_by_id(self.board.id).friends.each do |friend|
      friends << friend.id
    end
    friends
  end

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
