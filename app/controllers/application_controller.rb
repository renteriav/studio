class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :authenticate_user!
	protect_from_forgery

	protected

	def configure_permitted_parameters
    	devise_parameter_sanitizer.for(:sign_up) << [:loginable_id, :loginable_type]
  	end
  
end
