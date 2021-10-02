class Admin::OrdersController < ApplicationController
 before_action :authenticate_admin!

 def show
  @find_order = Order.find(params[:id])
  @customer_name = @find_order.customer.last_name + @find_order.customer.first_name
 end
 
 def update
   order = Order.find(params[:id])
   order.update(order_params)
   order_details = order.order_details
   if order.status_before_type_cast == 1 && order_details.where(making_status: 0).count == order.order_details.count
      order_details.each do |order_detail|
      order_detail.making_status = 1
      order_detail.update(order_detail_params)
      end
     redirect_to admin_path 
   else
    redirect_to admin_path
   end
 end
 
 private
  def order_params
   params.require(:order).permit(:customer_id,:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end
  
  def order_detail_params
   params.require(:order).permit(:making_status)
  end
end
