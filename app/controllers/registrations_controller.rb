class RegistrationsController < Devise::RegistrationsController
	def new
		if params[:teacher_id]
			@loginable = Teacher.find(params[:teacher_id])
			@loginable_id = @loginable.id
			@loginable_type = "Teacher"
		end
		if ! @loginable.nil?
			if @loginable.user
        		redirect_to @loginable
        	else
				build_resource({})
    			respond_with self.resource
    		end
    	else
    		build_resource({})
    		respond_with self.resource
    	end
	end

	def create
    build_resource(sign_up_params)
    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @loginable_type = params[:user][:loginable_type]
      @loginable_id = params[:user][:loginable_id]
      respond_with resource
    end
  end


end