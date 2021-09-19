class Order < ApplicationRecord
	belongs_to :customer
	has_many :order_details, dependent: :destroy
	enum payment_method: {credit_card: 0, transfer: 1 }
	enum status: { waited: 0, comfirm: 1, making: 2, posting: 3, posted: 4 }
end
