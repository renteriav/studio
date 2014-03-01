class AttendancesController < ApplicationController
  
  def index
    @lesson = Lesson.find(params[:lesson_id])
    @attendances = @lesson.attendances
  end
  
  def show
    @attendance = Attendance.find(params[:id])
  end
  
  def dialog
    @date = Time.parse(params[:date]).to_date
    if params[:lesson_id]
      @lesson = Lesson.find(params[:lesson_id])
    end
    
    if params[:extra_id]
      @lesson = Extra.find(params[:extra_id])
    end
    
    if @lesson.attendances.where("date = ?", @date).any?
      @attendance = @lesson.attendances.where("date = ?", @date).first
      @teacher_id = @attendance.teacher_id
    else
      @attendance = Attendance.new(:status => "s")
      @teacher_id = @lesson.teacher_id
    end
    
    @student = @lesson.student
    render :layout => false
  end
  
  def new
    @date = params[:date]
    @lesson = Lesson.find(params[:lesson_id])
    @attendance = Attendance.new(:status => "S")
    render :layout => false
  end
  
  def edit
    @date = params[:date]
    if params[:lesson_id]
      @lesson = Lesson.find(params[:lesson_id])
    end
    if params[:extra_id]
      @lesson = Lesson.find(params[:lesson_id])
    end
    @attendance = @lesson.attendances.where("date = ?", @date).first
  end

  def create
    @date = params[:date]
    @lesson = Lesson.find(params[:lesson_id])
    @attendance = @lesson.attendances.build(params[:attendance])

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to :back }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @attendance = Attendance.find(params[:id])
    @lesson = Lesson.find(@attendance.attendable_id)
    @student = Student.find(@lesson.student_id)
    if @attendance.update_attributes(params[:attendance])
      @attendance.teacher_id == "" or @attendance.teacher_id.nil? ? @notice = "Request for sub saved." : @notice = "#{Teacher.find(@attendance.teacher_id).first} has been succesfully assigned to sub for #{Teacher.find(@lesson.teacher_id).first}." 
      redirect_to :back, notice: @notice
    else
      render :action => 'edit'
    end
  end
  
  def sub_request
    @lesson = Lesson.find(params[:lesson_id])
    @student = Student.find(@lesson.student_id)
    @teacher = Teacher.find(@lesson.teacher_id)
    @instrument = Instrument.find(@lesson.instrument_id)
    @status = "s"
    ENV["TZ"] = "US/Phoenix"
    @date = DateTime.parse(params[:date])
    @sub_teachers = @lesson.instrument.teachers.map{|i| [i.first, i.id]}
    if @lesson.attendances.where("date = ?", @date).any?
      @selected = @lesson.attendances.where("date = ?", @date).first.teacher_id
    end
    if @lesson.attendances.where("date = ?", @date).any?
      @attendance = @lesson.attendances.where("date = ?", @date).first
    else
      @attendance = Attendance.new
    end
  end
  
end