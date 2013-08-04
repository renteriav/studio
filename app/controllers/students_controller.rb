class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def new
    @customer = Customer.find(params[:customer_id])
    @student = Student.new
    @student.telephones.build
  end

  def create
    @customer = Customer.find(params[:customer_id])
    @student = @customer.students.build(params[:student])
    respond_to do |format|
      if @student.save
        format.html { redirect_to customer_path(@customer), 
        notice: 'Student was successfully created.' }
      else
      render :action => 'new'
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
    if @student.update_attributes(params[:student])
      redirect_to students_url, :notice  => "Successfully updated student."
    else
      render :action => 'edit'
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
    @lessons = @student.lessons.order("weekday ASC, start_time ASC")
    @extras =  @student.extras.where("date >= ?", Time.now.to_date).order("date ASC")
    @date = Time.now.beginning_of_month
    @sharings = Sharing.where("date >= ?", Time.now.to_date)
    @detailed_sharing  = Array.new
    @sharing_signup = Array.new
    for sharing in @sharings
      @sharing = DetailedSharing.where("sharing_id = ? AND student_id = ?", sharing.id, @student.id).first
      @detailed_sharing.push(@sharing) unless @sharing.nil?     
    end
    if @detailed_sharing.any?
      for detail_sharing in @detailed_sharing
       @sharing = Sharing.find(detail_sharing.sharing_id)
       @sharing_signup.push(@sharing)
     end
    end
  end
  
  def attendance_search
    @student = Student.find(params[:id])
    @lessons = @student.lessons
    render :layout => false
  end
end
