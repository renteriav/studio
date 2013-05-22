class InstrumentsController < ApplicationController
  def index
    @instruments = Instrument.all
  end

  def show
    @instrument = Instrument.find(params[:id])
  end

  def new
    @instrument = Instrument.new
  end

  def edit
    @instrument = Instrument.find(params[:id])
  end

  def create
    @instrument = Instrument.new(params[:instrument])

    respond_to do |format|
      if @instrument.save
        format.html { redirect_to instruments_url, notice: 'Instrument was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @instrument = Instrument.find(params[:id])

    respond_to do |format|
      if @instrument.update_attributes(params[:instrument])
        format.html { redirect_to instruments_url, notice: 'Instrument was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
  def destroy
    @instrument = Instrument.find(params[:id])
    @instrument.destroy

    respond_to do |format|
      format.html { redirect_to instruments_url }
    end
  end
end
