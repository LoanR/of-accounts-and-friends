class Credit < ApplicationRecord
  belongs_to :creditor, class_name: 'Friend'
  belongs_to :debtor, class_name: 'Friend'
  belongs_to :board

  validates :creditor, presence: true
  validates :debtor, presence: true
  # validates :debtor, uniqueness: { scope: :creditor }
  validates :debtor, exclusion: { in: :creditor, message: "Cannot be in debt of its own credit!" }
  validates :amountint, presence: true

end
