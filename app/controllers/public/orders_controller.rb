class Public::OrdersController < ApplicationController
	def new
		@order = Order.new
		@order_detail = OrderDetail.new
  end
  
  def create
		@order = Order.new(order_params)
		@order.customer_id = current_customer.id
		@order.save
		@order_details = OrderDetail.new(order_details_params)
		@order_details.save
	  redirect_to 
  end
  
  private
  def order_params
   params.require(:order).permit(:customer_id,:postal_code,:address,:name,:shipping_cost,:total_payment,:payment_method,:status)
  end
  
  def order_details_params
   params.require(:order).permit(:order_id,:item_id,:price,:amount,:making_status)
  end
end
