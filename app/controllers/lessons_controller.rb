class LessonsController < ApplicationController

  def index
    @lessons = Lesson.all
  end

  def show
    @lesson = Lesson.find(params[:id])
  end

  def new
    @student = Student.find(params[:student_id])
    @lesson = Lesson.new
    @lesson_id = 0
    
    if params[:lesson]
      if params[:lesson][:instrument_id]
        @teachers = Instrument.find(params[:lesson][:instrument_id]).teachers.map{|i| [i.first, i.id]}
      end
      if params[:lesson][:teacher_id]
        @selected = params[:lesson][:teacher_id]
      end
      
    else
      @teachers = ""
    end
   
    
    gon.start_time = "03:00 PM"
    gon.end_time = "03:30 PM"
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @lesson_id = params[:id]
    @lesson = Lesson.find(params[:id])
    @teachers = @lesson.instrument.teachers.map{|i| [i.first, i.id]}
    @selected = @lesson.teacher.id
    gon.start_time = view_context.format_time(@lesson.start_time)
    gon.end_time = view_context.format_time(@lesson.end_time)
  end

  def create
    @student = Student.find(params[:student_id])
    @lesson = @student.lessons.build(params[:lesson])
    respond_to do |format|
      if @lesson.save
        format.html { redirect_to @lesson, notice: 'Lesson was successfully created.' }
      else
        if params[:lesson][:instrument_id] != ""
          @teachers = Instrument.find(params[:lesson][:instrument_id]).teachers.map{|i| [i.first, i.id]}
          if params[:lesson][:teacher_id] != ""
            @selected = params[:lesson][:teacher_id]
          end
        else
          @teachers = ""
        end
        @lesson_id = 0
        gon.start_time = params[:lesson][:start_time]
        gon.end_time = params[:lesson][:end_time]
        format.html { render action: "new" }
      end
    end
  end

  def update
    @lesson = Lesson.find(params[:id])
    @teachers = @lesson.instrument.teachers.map{|i| [i.first, i.id]}
    @selected = @lesson.teacher.id

    respond_to do |format|
      if @lesson.update_attributes(params[:lesson])
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
      else
        @lesson_id = params[:id]
        gon.start_time = params[:lesson][:start_time]
        gon.end_time = params[:lesson][:end_time]
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to lessons_url }
      format.json { head :no_content }
    end
  end
  
  def attendance_form
    @lesson = Lesson.find(params[:lesson_id])
  end
  
  def teacher_booking
    if params[:lesson_id]
      @lesson_id = params[:lesson_id]
    else
      @lesson_id = 0
    end
    @teacher = Teacher.find(params[:teacher_id])
    @weekday = params[:lesson_weekday]
    @start_date = params[:start_date]
    @start_time = params[:start_time_db]
    @end_time = params[:end_time_db]
    @room_id = params[:room_id]
    
    if /\A([0-9]{4}+)([-]+)([0-9]{2}+)([-]+)([0-9]{2})\z/.match(params[:end_date])
      @end_date = params[:end_date]
    else
      @end_date = "3000-01-01"
    end
    @lessons = @teacher.lessons.where("weekday = ? AND start_date <= ? AND (end_date >= ? OR end_date IS NULL) AND start_time < ? AND end_time > ? AND id <> ?", @weekday, @end_date, @start_date, @end_time, @start_time, @lesson_id).order("start_time ASC, end_time ASC")
    if @lessons.any?
      @lesson = @lessons.first
      @student = Student.find(@lesson.student_id)
      @weekday_name = Date::DAYNAMES[@lesson.weekday].pluralize
    end
    
    @room_conflicts = Lesson.where("weekday = ? AND start_date <= ? AND (end_date >= ? OR end_date IS NULL) AND start_time < ? AND end_time > ? AND room_id = ? AND id <> ?", @weekday, @end_date, @start_date, @end_time, @start_time, @room_id, @lesson_id).order("start_time ASC")
    
    if @room_conflicts.any?
      @room_conflict = @room_conflicts.first
    end
    
    render :layout => false
  end
  
end
