class Friend < ApplicationRecord
  belongs_to :board
  belongs_to :creator, class_name: 'User'
  has_many :transactions, foreign_key: :payer_id, dependent: :destroy
  has_many :credits, foreign_key: :creditor_id, dependent: :destroy
  has_many :credits, foreign_key: :debtor_id, dependent: :destroy

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :board


  def transactions_value
    val = 0
    self.transactions.each do |t|
      val += (t.amountint * 100 + t.amountdec)
    end
    val = sprintf "%02d", val
    int = val.split(/\d{2}\z/).join.reverse.gsub(/(\d{3})(?=.)/, '\1 \2').reverse
    int = int == '' ? '0' : int
    dec = val.split(//).last(2).join
    return int, dec
  end

  def balance
    average = 0
    val = 0
    board = Board.find_by_id(self.board.id)
    board.transactions.each do |t|
      average += (t.amountint * 1000 + t.amountdec * 10)
    end
    average /= board.friends.size == 0 ? 1 : board.friends.size
    self.transactions.each do |t|
      val += (t.amountint * 1000 + t.amountdec * 10)
    end
    balance = (average - val)
    balance = balance < 0 ? (sprintf "%04d", balance) : (sprintf "%03d", balance)
    int = balance.split(/\d{3}\z/).join.reverse.gsub(/(\d{3})(?=.)/, '\1 \2').reverse
    if int == '-'
      int = '-0'
    elsif int == ''
      int = '0'
    else
      int = int
    end
    dec = balance.split(//)[-3, 2].join
    bit = balance.split(//).last()
    return int, dec, bit
  end

  def loans
    loans = Credit.where(creditor: self)
  end

  def debts
    debts = Credit.where(debtor: self)
  end

  def credit_value(credits)
    amount = 0
    credits.each do |credit|
      amount += credit.amountint * 100 + credit.amountdec
    end
    amount_str = sprintf "%02d", amount
    int = amount_str.split(/\d{2}\z/).join.reverse.gsub(/(\d{3})(?=.)/, '\1 \2').reverse
    int = int == '' ? '0' : int
    dec = amount_str.split(//).last(2).join
    return int, dec
  end

  # def loans_value
  #   int = 0
  #   dec = 0
  #   loans = Credit.where(creditor: self)
  #   loans.each do |loan|
  # end

end
