class Friend < ApplicationRecord
  belongs_to :board

  validates :name, presence: true

end
