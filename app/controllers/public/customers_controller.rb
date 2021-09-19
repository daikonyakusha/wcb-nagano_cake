class Public::CustomersController < ApplicationController

 def edit
 	@customer=Customer.find(params[:id])
 end
 
 def update
 	@customer=Customer.find(params[:id])
 	@customer=Customer.update(params[:id])
 	redirect_to items_path
 end
 
 def quit
 end
 
 def show
  @customer = current_customer
 end
 
 def leave
  customer = current.customer
  customer.is_deleted = true
  redirect_to top_path
 end

private
 def customer_params
 	params.require(:customer).permit(:email,:password,:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code,:address,:telephone_number,:is_deleted)
 end
end
