class Admin::OrderDetailsController < ApplicationController
 before_action :authenticate_admin!

 def update
  order_detail = OrderDetail.find(params[:id])
  order_detail.update(order_detail_params)
  order= Order.find(params[:order_detail][:order_id].to_i)
  order.order_details
   if  order.status_before_type_cast <= 1 && order_detail.making_status_before_type_cast == 2
    order.status = 2
    order.update(order_params)
    redirect_to admin_path
   elsif order.status_before_type_cast <= 2 && order.order_details.where(making_status: 3).count == order.order_details.count
    order.status = 3
    order.update(order_params)
    redirect_to admin_path
   else
    redirect_to admin_path
   end
 end
 
 private
  def order_detail_params
   params.require(:order_detail).permit(:making_status)
  end
  def order_params
   params.require(:order_detail).permit(:customer_id,:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end
end
