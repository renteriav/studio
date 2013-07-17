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
    else
      @attendance = Attendance.new(:status => "s")
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
    if @attendance.update_attributes(params[:attendance])
      redirect_to :back
    else
      render :action => 'edit'
    end
  end
  
end