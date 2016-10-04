class Board < ApplicationRecord
  has_many :accounts
  has_many :users, through: :accounts
  has_many :friends
  has_many :credits
  has_many :transactions

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

end
