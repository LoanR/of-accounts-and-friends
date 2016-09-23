class Transaction < ApplicationRecord
  belongs_to :account

  # validates :creditor, presence: true
  validates :amount, presence: true

end
