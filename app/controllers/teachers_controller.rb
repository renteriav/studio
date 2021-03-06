class TeachersController < ApplicationController
  before_filter :check_for_mobile, :only => [:personal, :edit, :show]
  allow_oauth!
  def index
    @teachers = Teacher.all
  end

  def show
    if current_user
      @user = current_user
      if @user.loginable_type == "Teacher"
        @teacher = Teacher.find(@user.loginable_id)
        @mailing = @teacher.addresses.first
      end
    end
    #@teacher = Teacher.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @teacher }
    end
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
        @selected = params[:teacher][:addresses_attributes].values.first[:state]
        format.html { render action: "new" }
        if @teacher.telephones.empty? 
          @teacher.telephones.build
        end
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
        format.html #{ redirect_to @teacher, notice: 'Teacher was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        if @teacher.telephones.empty?
          @teacher.telephones.build
        end
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy

    respond_to do |format|
      format.html { redirect_to teachers_url }
      format.js
    end
  end

  def personal
    if current_user
      @user = current_user
      if @user.loginable_type == "Teacher"
        @teacher = Teacher.find(@user.loginable_id)
        @mailing = @teacher.addresses.first
        @teacher_cell = @teacher.telephones.where("description = 'Cell'").first
        @teacher_instruments = @teacher.instruments
        @instrument_ids = Array.new
        @teacher_instruments.each do |instrument|
          @instrument_ids.push(instrument.id)
        end
        @json_teacher = @teacher.attributes
        @json_teacher["cell"] = @teacher_cell.number
        @json_teacher["instrument_ids"] = @instrument_ids
        respond_to do |format|
          format.html
          format.json { render :json => @json_teacher }
        end
      end
    end
  end
  
end
