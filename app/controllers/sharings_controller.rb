class SharingsController < ApplicationController

  def index
    @sharings = Sharing.all
  end

  def show
    @sharing = Sharing.find(params[:id])
    @teachers = @sharing.teachers
    @detailed_sharings = DetailedSharing.where("sharing_id = ?", @sharing.id)
    @students = Array.new
    @detailed_sharings.each do |detailed_sharing|
      @students.push(Student.find(detailed_sharing.student_id))
      @students.sort_by!{ |m| [m.last, m.first] }
    end
    @attendance_total = @detailed_sharings.where("attendance = true").count
    @memory_total = @detailed_sharings.where("memory = true").count
    @practice_total = @detailed_sharings.where("practice = true").count
  end

  def new
    @sharing = Sharing.new
    @teachers = ""
    gon.start_time = "04:00 PM"
    gon.end_time = "05:00 PM"
  end

  def edit
    @sharing = Sharing.find(params[:id])
    @date = @sharing.date.strftime("%m/%d/%Y")
    gon.start_time = view_context.format_time(@sharing.start_time)
    gon.end_time = view_context.format_time(@sharing.end_time)
  end

  def create
    @sharing = Sharing.new(params[:sharing])
    respond_to do |format|
      if @sharing.save
        format.html { redirect_to @sharing, notice: 'Sharing was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    params[:sharing][:teacher_ids] ||= []
    @sharing = Sharing.find(params[:id])

    respond_to do |format|
      if @sharing.update_attributes(params[:sharing])
        format.html { redirect_to @sharing, notice: 'Sharing was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
  def destroy
    @sharing = Customer.find(params[:id])
    @sharing.destroy

    respond_to do |format|
      #format.html { redirect_to sharings_url }
      format.js
    end
  end
  
  
  def teachers_cbx
    @lessons = Lesson.where("weekday = ?", params[:weekday].to_i)
    @teachers = Array.new
    for lesson in @lessons
      @teachers.push(lesson.teacher_id)
    end 
    
    render :layout => false
  end
  
end
