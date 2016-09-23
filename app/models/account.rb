class Account < ApplicationRecord
  has_many :users, through: :user_account_link
  has_many :credits
  has_many :transactions

  validates :title, presence: true

end
