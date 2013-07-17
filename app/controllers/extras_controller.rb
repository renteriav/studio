class ExtrasController < ApplicationController

  def index
    @extras = Extra.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @extra = Extra.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @student = Student.find(params[:student_id])
    @extra = Extra.new
    @extra.attendances.build
    @teachers = ""

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @extra = Extra.find(params[:id])
    @teachers = @extra.instrument.teachers.map{|i| [i.first, i.id]}
    @selected = @extra.teacher.id
    @date = @extra.date.strftime("%m/%d/%Y")
    gon.start_time = view_context.format_time(@extra.start_time)
    gon.end_time = view_context.format_time(@extra.end_time)
  end

  def create
    @student = Student.find(params[:student_id])
    @extra = @student.extras.build(params[:extra])
    respond_to do |format|
      if @extra.save
        format.html { redirect_to @extra, notice: 'Lesson was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @extra = Extra.find(params[:id])
    @teachers = @extra.instrument.teachers.map{|i| [i.first, i.id]}
    @selected = @extra.teacher.id

    respond_to do |format|
      if @extra.update_attributes(params[:extra])
        format.html { redirect_to @extra, notice: 'Lesson was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @extra = Extra.find(params[:id])
    @extra.destroy

    respond_to do |format|
      format.html { redirect_to extras_url }
      format.json { head :no_content }
    end
  end
  
  def attendance_form
    @extra = Extra.find(params[:extra_id])
  end
  
end
