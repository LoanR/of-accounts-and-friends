class Transaction < ApplicationRecord
  belongs_to :board

  # validates :creditor, presence: true
  validates :amount, presence: true

end
