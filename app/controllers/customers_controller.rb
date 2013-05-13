class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
    @customer.telephones.build
    @address = @customer.addresses.build
    @address.build_mailing_address

  end

  def edit
   @customer = Customer.find(params[:id])
  end

  def create
    @customer = Customer.new(params[:customer])

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
      else
        format.html { render action: "edit" }
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
      @search_result = Customer.find(:all, conditions: ["first LIKE ? AND last LIKE ?", "#{@first_keyword}%", "#{@last_keyword}%"])
    end

    render :layout => false
  end
end
