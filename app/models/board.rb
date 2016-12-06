class Board < ApplicationRecord
  has_many :accounts
  has_many :users, through: :accounts
  has_many :friends
  has_many :transactions, through: :friends
  has_many :credits, through: :friends

  validates :title, presence: true

  def authorized_user?(user)
    bs = Board.find_by_id(self.id)
    belong = user.boards.select do |b|
      b == bs
    end
    true if belong.first
  end

  def give_access_to(user)
    new_account = Account.new
    new_account.board_id = self.id
    user_exists = User.find_by_email(user) || User.find_by_username(user)
    if user_exists
      new_account.user_id = user_exists.id
      new_account.save
    else
      false
    end
  end

  def board_sum
    sum = 0
    self.transactions.each do |t|
      sum += (t.amountint * 100 + t.amountdec)
    end
    sum = sprintf "%02d", sum
    int = sum.split(/\d{2}\z/).join.reverse.gsub(/(\d{3})(?=.)/, '\1 \2').reverse
    int = int == '' ? '0' : int
    dec = sum.split(//).last(2).join
    return int, dec
  end

  def average_expenses
    average = 0
    self.transactions.each do |t|
      average += (t.amountint * 1000 + t.amountdec * 10)
    end
    average /= self.friends.size == 0 ? 1 : self.friends.size
    average = sprintf "%03d", average
    int = average.split(/\d{3}\z/).join.reverse.gsub(/(\d{3})(?=.)/, '\1 \2').reverse
    int = int == '' ? '0' : int
    dec = average.split(//)[-3, 2].join
    bit = average.split(//).last()
    return int, dec, bit
  end

  def get_friends_ids
    friends_ids = []
    self.friends.each do |friend|
      friends_ids << friend.id
    end
    friends_ids
  end

end
