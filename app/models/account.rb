class Account < ApplicationRecord
  belongs_to :user
  belongs_to :creator, class_name: 'User'
  belongs_to :board

  validates_uniqueness_of :user, scope: :board

end
