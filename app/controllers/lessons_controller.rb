class LessonsController < ApplicationController

  def index
    @lessons = Lesson.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @lesson = Lesson.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @student = Student.find(params[:student_id])
    @lesson = Lesson.new
    @teachers = ""
    gon.start_time = "03:00 PM"
    gon.end_time = "03:30 PM"
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
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
  
end
