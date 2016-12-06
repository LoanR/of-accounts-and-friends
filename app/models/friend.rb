class Friend < ApplicationRecord
  belongs_to :board
  has_many :transactions, foreign_key: :payer_id
  has_many :credits, foreign_key: :creditor_id
  has_many :credits, foreign_key: :debtor_id

  validates :name, presence: true

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

end
