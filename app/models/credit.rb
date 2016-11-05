class Credit < ApplicationRecord
  belongs_to :board
  has_one :creditor, through: :board, class_name: "Friend"
  has_one :debtor, through: :board, class_name: "Friend"


  validates :creditor, presence: true
  validates :debtor, presence: true
  # validates :debtor, uniqueness: { scope: :creditor }
  validates :debtor, exclusion: { in: :creditor, message: "Cannot be in debt of its own credit!"
  validates :amountint, presence: true

end
