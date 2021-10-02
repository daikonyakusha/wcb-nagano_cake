class Public::CustomersController < ApplicationController
 before_action :authenticate_customer!
 
 def edit
 	@customer= current_customer
 end
 
 def update
 	@customer = current_customer
 	@customer.id = current_customer.id 
 	@customer.update(customer_params)
 	redirect_to customers_path
 end
 
 def quit
 end
 
 def show
  @customer = current_customer
 end
 
 def leave
  customer = current_customer
  #customer.is_deleted = true
  customer.update(is_deleted: true)
  reset_session
  redirect_to root_path
 end

private
 def customer_params
 	params.require(:customer).permit(:email,:password,:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code,:address,:telephone_number,:is_deleted)
 end
end
