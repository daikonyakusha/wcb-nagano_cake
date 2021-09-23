class Public::CartItemsController < ApplicationController

def create
 @cart_items = current_customer.cart_items
  @find_cart_item = @cart_items.find_by(item_id: params[:cart_item][:item_id])
  if @find_cart_item 
    @find_cart_item.update(amount: @find_cart_item.amount + params[:cart_item][:amount].to_i)
    redirect_to cart_items_path
    # @find_cart_item.update(amount: すでにカートにある個数 +　追加する個数)
    #すでにかーとにある個数 = @find_cart_item.amount
    #追加する個数 = params[:cart_item][:amount] ←修正が必要
  else
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
 redirect_to cart_items_path
  end
end

def index
 @cart_items = current_customer.cart_items
 @total_amount = 0
end

def destroy_all
 current_customer.cart_items.destroy_all
end

def destroy
 cart_item = CartItem.find(params[:id])
 cart_item.destroy
 redirect_to cart_items_path
end


def update
 cart_item = CartItem.find(params[:id])
 cart_item.update(cart_item_params)
 redirect_to cart_items_path
end

private
def cart_item_params
 params.require(:cart_item).permit(:customer_id,:item_id,:amount)
end

end
