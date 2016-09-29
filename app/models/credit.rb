class Credit < ApplicationRecord
  belongs_to :board

  # validates :creditor, presence: true
  # validates :debtor, presence: true
  # validates :debtor, exclusion: :creditor
  validates :amount, presence: true

end
