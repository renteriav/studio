class AttendancesController < ApplicationController
  
  def index
    @lesson = Lesson.find(params[:lesson_id])
    @attendances = @lesson.attendances
    respond_to do |format|
      format.html
      format.json { render :json => @attendances }
    end
  end
  
  def show
    @attendance = Attendance.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @attendance }
    end
  end
  
  def dialog
    @date = Time.parse(params[:date]).to_date
    
    if params[:lesson_id]
      @lesson = Lesson.find(params[:lesson_id])  
    elsif params[:extra_id]
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
    elsif params[:extra_id]
      @lesson = Extra.find(params[:lesson_id])
    end
    @attendance = @lesson.attendances.where("date = ?", @date).first
  end

  def create
    @date = params[:date]
    
    @lesson = Lesson.find(params[:lesson_id])
    @teacher = Teacher.find(@lesson.teacher_id)
 
    @attendance = @lesson.attendances.build(attendance_params)

    respond_to do |format|
      if @attendance.save
        @sub = Teacher.find(params[:attendance][:teacher_id])
        if @sub and params[:send_email] == "send"
          AttendanceMailer.sub_confirmation(@sub, @teacher).deliver
        end

        format.html #{ redirect_to :back }
        format.json { head :no_content }
      else
        format.html { render action: "new" }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @attendance = Attendance.find(params[:id])
    if params[:lesson_id]
      @lesson = Lesson.find(params[:lesson_id])  
    elsif params[:extra_id]
      @lesson = Extra.find(params[:extra_id])
    else
      @lesson = Lesson.find(@attendance.attendable_id)
    end
    @student = Student.find(@lesson.student_id)
    @teacher = Teacher.find(@lesson.teacher_id)
    @current_teacher = Teacher.find(@attendance.teacher_id)
    respond_to do |format|
      if @attendance.update_attributes(attendance_params)
        if params[:attendance][:status].nil?
          @attendance.teacher_id == "" or @attendance.teacher_id.nil? ? @notice = "Request for sub saved." : @notice = "#{Teacher.find(@attendance.teacher_id).first} has been succesfully assigned to sub for #{Teacher.find(@lesson.teacher_id).first}."
        end
        @sub = Teacher.find(params[:attendance][:teacher_id])
        if @sub and params[:sub_confirmation_email] == "send"
          AttendanceMailer.sub_confirmation(@sub, @teacher, @attendance, @lesson, @student).deliver
        elsif params[:cancelation_email] == "send"
          AttendanceMailer.cancelation(@current_teacher, @attendance, @lesson, @student).deliver
        end
        format.html #redirect_to :back, notice: @notice
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
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
  private
  
  def attendance_params
  params.require(:attendance).permit(:attendable_id, :attendable_type, :date, :status, :teacher_id) 
  end
    
end