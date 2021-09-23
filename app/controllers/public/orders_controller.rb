class Public::OrdersController < ApplicationController
  def new
	  @order = Order.new
	  @order_detail = OrderDetail.new
	  @address = Address.new
	  @customer = current_customer
  end
  
  def comfirm
    @address_option = params[:order][:address_option]
    @cart_items = current_customer.cart_items
    @total_amount = 0
    @order = Order.new(order_params)
    
   if @address_option == "0"
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
    @order.shipping_cost = 800
    @total_amount_all = @total_amount + @order.shipping_cost
   elsif @address_option == "1"
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
    @order.shipping_cost = 800
    @total_amount_all = @total_amount + @order.shipping_cost
    
   elsif @address_option == "2"
    @order.shipping_cost = 800
    @address = Address.new(address_params)
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
    @total_amount_all = @total_amount + @order.shipping_cost
    
   else
    render :cart_items
   end
  end
  
  def create
   order = Order.new(order_params)
   order.customer_id = current_customer.id
   address_option = params[:order][:address_option]
   
  if address_option == "2"
    address = Address.new(address_params)
    address.customer_id = current_customer.id
    address.postal_code = order.postal_code
    address.address = order.address
    address.name = order.name
    address.save
  end
    order.save
    cart_items = current_customer.cart_items.all
    cart_items.each do |cart_item|
     order_detail = OrderDetail.new(order_detail_params)
     order_detail.order_id = order.id
     order_detail.item_id = cart_item.item_id
     order_detail.price = cart_item.item.price
     order_detail.amount = cart_item.amount
     order_detail.making_status = 1
     order_detail.save
     current_customer.cart_items.destroy_all
  	  redirect_to orders_thanks_path
  	 end
  end 

  def index
   @orders = current_customer.order.all
  end 
  
  def show
   @order = Order.find(params[:id])
  end 
  
  def thanks
  end 
  
  private
  def order_params
   params.require(:order).permit(:customer_id,:postal_code,:address,:name,:shipping_cost,:total_payment,:payment_method,:status)
  end
  
  def order_detail_params
   params.require(:order).permit(:order_id,:item_id,:price,:amount,:making_status)
  end
  
  def address_params
   params.require(:order).permit(:address,:postal_code,:name,:customer_id)
  end
end
