class Friend < ApplicationRecord
  belongs_to :board
  # has_many :transactions, through: :board

  validates :name, presence: true

end
