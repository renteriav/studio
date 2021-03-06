class StudentsController < ApplicationController
  before_filter :authenticate_user!
  allow_oauth! :except => :delete
  
  def index
    @students = Student.order("last ASC")
    respond_to do |format|
      format.html
      format.json { render :json => @students }
    end
      
  end

  def new
    @customer = Customer.find(params[:customer_id])
    @student = Student.new
    @student.telephones.build
  end

  def create
    @customer = Customer.find(params[:customer_id])
    #@student = @customer.students.build(params[:student])
    @student = @customer.students.build(student_params)
    respond_to do |format|
      if @student.save
        format.html { redirect_to student_path(@student), 
        notice: 'Student was successfully created.' }
      else
      format.html { render action: "new" }
        if @student.telephones.empty? 
          @student.telephones.build
        end
      end
    end
  end

  def edit
    @student = Student.find(params[:id])
    if @student.telephones.empty? 
      @student.telephones.build
    end
  end

  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(student_params)
      redirect_to @student, notice: 'Student was successfully updated.'
    else
      render :action => 'edit'
      if @student.telephones.empty? 
        @student.telephones.build
      end
    end
  end
  
  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to customer_students_url }
      format.json { head :no_content }
    end
  end
  
  def show
    @student = Student.find(params[:id])
    @id = @student.id
    @lessons = @student.lessons.where("(end_date > ? OR end_date IS NULL)",Time.now).order("weekday ASC, start_time ASC")
    @extras =  @student.extras.where("date >= ?", Time.now.to_date).order("date ASC")
    @sharings = Sharing.where("date >= ? AND date <= ?", Time.now.beginning_of_month, Time.now.end_of_month)
    @upcoming_sharings = Sharing.where("date >= ?", Time.now)
    @date = Time.now.to_date.beginning_of_month
    @detailed_sharing  = Array.new
    @sharing_signup = Array.new
    @upcoming_detailed_sharings = Array.new
    for sharing in @sharings
      @sharing = DetailedSharing.where("sharing_id = ? AND student_id = ?", sharing.id, @student.id).first
      @detailed_sharing.push(@sharing) unless @sharing.nil?     
    end
    
    for sharing in @upcoming_sharings
      @sharing = DetailedSharing.where("sharing_id = ? AND student_id = ?", sharing.id, @student.id).first
      @upcoming_detailed_sharings.push(@sharing) unless @sharing.nil?     
    end
    
      @json_student = @student.attributes
      @customer = Customer.find(@student.customer_id)
      @json_student["customer"] = @customer.attributes
      @json_student["customer"]["telephones"] = @customer.telephones
      @mailing_address = @customer.preferred_addresses.where("description = 'mailing'")
      if @mailing_address.any?
       @mailing_address_id = @mailing_address.first.id
        @json_student["customer"]["mailing_address"] = Address.find(@mailing_address_id)
      end
    
    respond_to do |format|
      format.html
      format.json { render :json => @json_student }
    end
  end
  
  def attendance
    @student = Student.find(params[:student_id])
    @id = @student.id
    @lessons = @student.lessons.order("weekday ASC, start_time ASC")
    @extras =  @student.extras.where("date >= ?", Time.now.to_date).order("date ASC")
    @sharings = Sharing.where("date >= ? AND date <= ?", Time.now.beginning_of_month, Time.now.end_of_month)
    @upcoming_sharings = Sharing.where("date >= ?", Time.now)
    @date = Time.now.to_date.beginning_of_month
    @detailed_sharing  = Array.new
    @sharing_signup = Array.new
    @upcoming_detailed_sharings = Array.new
    for sharing in @sharings
      @sharing = DetailedSharing.where("sharing_id = ? AND student_id = ?", sharing.id, @student.id).first
      @detailed_sharing.push(@sharing) unless @sharing.nil?     
    end
    if @detailed_sharing.any?
      for detailed_sharing in @detailed_sharing
       @sharing = Sharing.find(detailed_sharing.sharing_id)
       @sharing_signup.push(@sharing)
      end
    end
  end
  
  def attendance_search
    @student = Student.find(params[:id])
    @lessons = @student.lessons
    render :layout => false
  end
  
  private
  
  def student_params
  params.require(:student).permit(:first, :last, :email, :birthdate, :grade, :customer_id, :schoolyear, telephones_attributes: [ :id, :_destroy, :number, :description ]) 
  end
end
