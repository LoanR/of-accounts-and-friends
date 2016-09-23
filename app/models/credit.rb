class Credit < ApplicationRecord
  belongs_to :account

  # validates :creditor, presence: true
  # validates :debtor, presence: true
  # validates :debtor, exclusion: :creditor
  validates :amount, presence: true

end
