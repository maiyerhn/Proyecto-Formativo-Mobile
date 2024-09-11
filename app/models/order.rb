class Order < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :status, presence: true, length: { maximum: 80 }
  validates :total, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
