class Board < ApplicationRecord
  has_many :users, through: :accounts
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

end
