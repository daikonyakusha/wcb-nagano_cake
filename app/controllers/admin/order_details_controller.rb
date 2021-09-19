class Admin::OrderDetailsController < ApplicationController

 def update
  @order_detail = Order_detail.find(params[:id])
  order_detail.update
  ##redirect_to _path
 end
 
 private
  def order_detail_params
   params.require(:order_detail).permit(:order_id,:item_id,:price,:amount,:making_status)
  end
end
