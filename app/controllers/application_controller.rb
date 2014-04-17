class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :authenticate_user!

	protect_from_forgery

	private

	def check_for_mobile
  		session[:mobile_override] = params[:mobile] if params[:mobile]
  		prepare_for_mobile if mobile_device?
	end

	def prepare_for_mobile
  		prepend_view_path Rails.root + 'app' + 'views_mobile'
	end
	
	def mobile_device?
  		if session[:mobile_override]
    		session[:mobile_override] == "1"
  		else
    		(request.user_agent =~ /Mobile|webOS/) && (request.user_agent !~ /iPad/)
  		end
	end

	helper_method :mobile_device?

	protected

	def configure_permitted_parameters
    	devise_parameter_sanitizer.for(:sign_up) << [:loginable_id, :loginable_type]
  	end
  
end
