class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

protected

  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys:[:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code,:address,:telephone_number])
  end
 	
  def after_sign_in_path_for(resorce)
    case resource
    when Admin
      admin_path          #pathは設定したい遷移先へのpathを指定してください
    when Customer
      root_path              #ここもpathはご自由に変更してください
    end
  end
 	
  def after_sign_out_path_for(resorce)
   case resorce
    when :admin
       new_admin_session_path          #pathは設定したい遷移先へのpathを指定してください
    when :customer
      root_path              #ここもpathはご自由に変更してください
   end
  end
  
end
