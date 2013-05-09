class TelephonesController < ApplicationController
  def index
    @customer = Customer.find(params[:customer_id])
    @telephones = @customer.telephones
  end

  def show
    @customer = Customer.find(params[:customer_id])
    @telephone = Telephone.find(params[:id])
  end

  def new
    @customer = Customer.find(params[:customer_id])
    @telephone = Telephone.new
  end

  def edit
    @customer = Customer.find(params[:customer_id])
    @telephone = Telephone.find(params[:id])
  end

  def create
    @customer = Customer.find(params[:customer_id])
    @telephone = @customer.telephones.build(params[:telephone])
    respond_to do |format|
      if @telephone.save
        format.html { redirect_to customer_telephone_path(@customer, @telephone), 
          notice: 'Customer telephone was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @customer = Customer.find(params[:customer_id])
    @telephone = @customer.telephones.find(params[:id])

    respond_to do |format|
      if @telephone.update_attributes(params[:telephone])
        format.html { redirect_to customer_telephone_path(@customer, @telephone), 
          notice: 'Telephone was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @telephone.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @telephone = Telephone.find(params[:id])
    @telephone.destroy

    respond_to do |format|
      format.html { redirect_to customer_telephones_url }
      format.json { head :no_content }
    end
  end
end
