class LessonsController < ApplicationController

  def index
    @lessons = Lesson.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lessons }
    end
  end

  def show
    @lesson = Lesson.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lesson }
    end
  end

  def new
    @student = Student.find(params[:student_id])
    @lesson = Lesson.new
    @teachers = ""

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lesson }
    end
  end

  def edit
    @lesson = Lesson.find(params[:id])
    @teachers = @lesson.instrument.teachers.map{|i| [i.first, i.id]}
    @selected = @lesson.teacher.id
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
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to lessons_url }
      format.json { head :no_content }
    end
  end
  
  def update_teachers
    if params[:instrument_id] == ''
    @teachers = [['Select a teacher', ""]]
    else
    @instrument = Instrument.find(params[:instrument_id])
    @teachers = @instrument.teachers.map{|i| [i.first, i.id]}.insert(0, ["Select a teacher", ""])
    end
    render :layout => false
  end
end
