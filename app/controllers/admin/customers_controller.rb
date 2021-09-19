class Admin::CustomersController < ApplicationController
	
	def index
	 @customers= Customer.page(params[:page]).reverse_order
	end
	
	def create
	 customer= Customer.new(customer_params)
	 customer.save
	 ##redirect_to _path
	end
	
	def show
	 @customer= current_customer
	end
	
	def edit
	 @customer= Customer.find(params[:id])
	end
	
	def update
	 customer = Customer.find(params[:id])
	 customer.update(customer_params)
	 redirect_to admin_customer_path
	end
	
	private
	def customer_params
	 params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:email,:encrypted_password,:postal_code,:address,:telephone_number,:is_deleted)
	end
end
