class PreferredAddressesController < ApplicationController
  # GET /preferred_addresses
  # GET /preferred_addresses.json
  def index
    @preferred_addresses = PreferredAddress.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @preferred_addresses }
    end
  end

  # GET /preferred_addresses/1
  # GET /preferred_addresses/1.json
  def show
    @preferred_address = PreferredAddress.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @preferred_address }
    end
  end

  # GET /preferred_addresses/new
  # GET /preferred_addresses/new.json
  def new
    @preferred_address = PreferredAddress.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @preferred_address }
    end
  end

  # GET /preferred_addresses/1/edit
  def edit
    @preferred_address = PreferredAddress.find(params[:id])
  end

  # POST /preferred_addresses
  # POST /preferred_addresses.json
  def create
    @preferred_address = PreferredAddress.new(params[:preferred_address])

    respond_to do |format|
      if @preferred_address.save
        format.html { redirect_to @preferred_address, notice: 'Preferred address was successfully created.' }
        format.json { render json: @preferred_address, status: :created, location: @preferred_address }
      else
        format.html { render action: "new" }
        format.json { render json: @preferred_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /preferred_addresses/1
  # PUT /preferred_addresses/1.json
  def update
    @preferred_address = PreferredAddress.find(params[:id])

    respond_to do |format|
      if @preferred_address.update_attributes(params[:preferred_address])
        format.html { redirect_to @preferred_address, notice: 'Preferred address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @preferred_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /preferred_addresses/1
  # DELETE /preferred_addresses/1.json
  def destroy
    @preferred_address = PreferredAddress.find(params[:id])
    @preferred_address.destroy

    respond_to do |format|
      format.html { redirect_to preferred_addresses_url }
      format.json { head :no_content }
    end
  end
end
