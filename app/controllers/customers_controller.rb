class CustomersController < ApplicationController
  def index
    @customers = Customer.order("last ASC")
  end

  def show
    @customer = Customer.find(params[:id])
    @preferred_mailing = @customer.preferred_addresses.where("description = 'mailing'").last
    if @preferred_mailing
    @mailing = @customer.addresses(@preferred_mailing.address_id).first
    end
    @students = @customer.students
  end

  def new
    @customer = Customer.new
    @customer.telephones.build
    @address = @customer.addresses.build
    @address.preferred_addresses.build
    @selected = 'AZ'
    @address_description = 'mailing'
  end

  def edit
   @customer = Customer.find(params[:id])
    @preferred_mailing = @customer.preferred_addresses.where("description = 'mailing'").last
    if @preferred_mailing
     @selected = @customer.addresses(@preferred_mailing.address_id).first.state
    else
     @address = @customer.addresses.build
     @address.preferred_addresses.build
     @selected = 'AZ'
    end
     @address_description = 'mailing'
   if @customer.telephones.empty? 
     @customer.telephones.build
   end
  end

  def create
    #@customer = Customer.new(params[:customer])
    @customer = Customer.new(customer_params)
    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
      else
        @selected = params[:customer][:addresses_attributes].values.first[:state]
        @address_description = 'mailing'
        format.html { render action: "new" }
        if @customer.telephones.empty? 
          @customer.telephones.build
        end
      end
    end
  end

  def update
    @customer = Customer.find(params[:id])
    @preferred_mailing = @customer.preferred_addresses.where("description = 'mailing'").last
    @selected = @customer.addresses(@preferred_mailing.address_id).first.state unless @customer.addresses.empty?
    @address_description = 'mailing'

    respond_to do |format|
     # if @customer.update_attributes(params[:customer])
      if @customer.update_attributes(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
      else
        format.html { render action: "edit" }
        if @customer.telephones.empty? 
          @customer.telephones.build
        end
      end
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      #format.html { redirect_to customers_url }
      format.js
    end
  end

  def live_search
   @first_keyword = params[:keyword1]
   @last_keyword = params[:keyword2]
    if @first_keyword != "" || @last_keyword != ""
      @search_result = Customer.find(:all, conditions: ["first ILIKE ? AND last ILIKE ?", "#{@first_keyword}%", "#{@last_keyword}%"])
    end

    render :layout => false
  end
  
  private

      def customer_params
        params.require(:customer).permit(:email, :first, :last,     
          telephones_attributes: [ :id, :_destroy, :number, :description ], 
          addresses_attributes: [ :id, :street, :city, :state, :zip, :addressable_id, :addressable_type, 
            preferred_addresses_attributes: [ :id, :address_id, :description ]])
      end
end
