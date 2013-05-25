class TeachersController < ApplicationController

  def index
    @teachers = Teacher.all
  end

  def show
    @teacher = Teacher.find(params[:id])
    @mailing = @teacher.addresses.first
  end

  def new
    @teacher = Teacher.new
    @teacher.telephones.build
    @teacher.addresses.build
    @selected = 'AZ'
    @address_description = 'mailing'
  end

  def edit
    @teacher = Teacher.find(params[:id])
    @selected = @teacher.addresses.first.state
    @address_description = 'mailing'
    if @teacher.telephones.empty? 
      @teacher.telephones.build
    end
  end

  def create
    @teacher = Teacher.new(params[:teacher])

    respond_to do |format|
      if @teacher.save
        format.html { redirect_to @teacher, notice: 'Teacher was successfully created.' }
      else
        if @teacher.telephones.empty? 
          @teacher.telephones.build
        end
        @selected = params[:teacher][:addresses_attributes].values.first[:state]
        format.html { render action: "new" }
        @address_description = 'mailing'
      end
    end
  end

  def update
    params[:teacher][:instrument_ids] ||= []
    @teacher = Teacher.find(params[:id])
    @selected = @teacher.addresses.first.state
    @address_description = 'mailing'

    respond_to do |format|
      if @teacher.update_attributes(params[:teacher])
        format.html { redirect_to @teacher, notice: 'Teacher was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy

    respond_to do |format|
      format.html { redirect_to teachers_url }
    end
  end
end