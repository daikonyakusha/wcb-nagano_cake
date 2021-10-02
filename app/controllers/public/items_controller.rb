class Public::ItemsController < ApplicationController
	
  def index
   @genres = Genre.all
   if params[:search].present?
 	  @genre = Genre.find(params[:search][:value].to_i)
    @items = @genre.items.page(params[:page]).reverse_order
    @total_item = @genre.items
   else
  		@items = Item.page(params[:page]).reverse_order
  		@total_item = Item.all
   end
  end
  
  def show
   @genres = Genre.all
   @item = Item.find(params[:id])
   @cart_item = CartItem.new
  end
  
  private
  def item_params
   params.require(:item).permit(:genre_id,:name,:image,:introduction, :price,:is_active)	
  end	
  
  private
  def cart_item_params
   params.require(:cart_item).permit(:customer_id,:item_id,:amount)
  end

end
