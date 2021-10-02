class Admin::HomesController < ApplicationController
	before_action :authenticate_admin!
	
 def top
  if params[:search].present?
   @customer=Customer.find(params[:search][:value].to_i)
   @orders =@customer.orders.page(params[:page]).reverse_order
  else
   @orders=Order.page(params[:page]).reverse_order
   @total_amount = 0
  end
 end

end
