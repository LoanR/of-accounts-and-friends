class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :accounts
  has_many :boards, through: :accounts

  def user_boards
    boards = []
    self.accounts.each do |account|
      boards << account.board
    end
    boards
  end



end
