class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :order_id, presence: true
  validates :product_id, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :total, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
