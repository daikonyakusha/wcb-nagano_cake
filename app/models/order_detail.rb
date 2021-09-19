class OrderDetail < ApplicationRecord
	belongs_to :item
	belongs_to :order
  enum making_status: {impossible: 0, waited: 1, making: 2, maked: 3 }
end
