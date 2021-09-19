class Admin::HomesController < ApplicationController
	def top
	 @orders=Order.page(params[:page]).reverse.order
  end
end
