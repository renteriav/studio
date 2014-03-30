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
    @lesson_id = 0
    @student = Student.find(params[:student_id])
    @extra = Extra.new
    @extra.attendances.build
    if params[:extra]
      if params[:extra][:instrument_id]
        @teachers = Instrument.find(params[:extra][:instrument_id]).teachers.map{|i| [i.first, i.id]}
      end
      if params[:extra][:teacher_id]
        @selected = params[:extra][:teacher_id]
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
        if params[:extra][:instrument_id] != ""
          @teachers = Instrument.find(params[:extra][:instrument_id]).teachers.map{|i| [i.first, i.id]}
          if params[:extra][:teacher_id] != ""
            @selected = params[:extra][:teacher_id]
          end
        else
          @teachers = ""
        end
        @lesson_id = 0
        @date = params[:"date-box"]
        gon.start_time = params[:extra][:start_time]
        gon.end_time = params[:extra][:end_time]
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
        @lesson_id = params[:id]
        @date = params[:"date-box"]
        gon.start_time = params[:extra][:start_time]
        gon.end_time = params[:extra][:end_time]
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @extra = Extra.find(params[:id])
    @extra.destroy

    respond_to do |format|
      #format.html { redirect_to extras_url }
      format.js
    end
  end
  
  def attendance_form
    @extra = Extra.find(params[:extra_id])
  end
  
  def teacher_booking
    if params[:lesson_id] 
      @lesson_id = params[:lesson_id]
    else
      @lesson_id = 0
    end #checks if it's an existing lesson to exclude it from the search and avoid conflicting with itself.
    @teacher = Teacher.find(params[:teacher_id])
    @weekday = DateTime.parse(params[:start_date]).wday
    @start_date = params[:start_date]
    @start_time = params[:start_time_db]
    @end_time = params[:end_time_db]
    @room_id = params[:extra_room_id]
    
    @lessons = @teacher.lessons.where("weekday = ? AND start_date <= ? AND (end_date >= ? OR end_date IS NULL) AND start_time < ? AND end_time > ?", @weekday, @start_date, @start_date, @end_time, @start_time).order("start_time ASC, end_time ASC")
    
    @extras = @teacher.extras.where("date = ? AND start_time < ? AND end_time > ? AND id <> ?", @start_date, @end_time, @start_time, @lesson_id )
    if @extras.any?
      @extras.each do |extra|
        @extra_lesson = Lesson.new(comp_id: extra.category, room_id: extra.room_id, instrument_id: extra.instrument_id, student_id: extra.student_id, start_date: extra.date, start_time: extra.start_time, end_time: extra.end_time, weekday: extra.date.wday)
        @lessons = @lessons.to_a.push(@extra_lesson)
      end
    end
    if @lessons.any?
      @lessons.each do |lesson|
        @id = lesson.id
        @openings = Attendance.where("attendable_id = ? AND attendable_type = ? AND status = ? AND date = ? AND teacher_id = ?", @id, "Lesson", "c", @start_date, @teacher.id )
        if @openings.any?
          @openings.each do |opening|
            @lessons.delete_if{|k, v| k.id == opening.attendable_id}
          end
        end
      end
    end
   
   if @lessons.any?     
     @lesson = @lessons.first
     @student = Student.find(@lesson.student_id)
     if @lesson.comp_id == "" or @lesson.comp_id.nil?
       @type = "Regular Lesson"
     else
       @type = view_context.extra_category_description(@lesson.comp_id)
     end
   end 
   
   #room conflicts
   if @room_id = 1
     @sharing_room_conflicts = Sharing.where("date = ? AND start_time < ? AND end_time > ?", @start_date, @end_time, @start_time).order("start_time ASC").first
     
   end
  
   
   @room_conflicts = Lesson.where("weekday = ? AND start_date <= ? AND (end_date >= ? OR end_date IS NULL) AND start_time < ? AND end_time > ? AND room_id = ?", @weekday, @start_date, @start_date, @end_time, @start_time, @room_id).order("start_time ASC")
   if @room_conflicts.any?
     @room_conflicts.each do |lesson|
       @comp_id = lesson.id.to_s + "-Lesson"
       lesson.comp_id = @comp_id
     end
   end
   
   
   @extras_room_conflicts = Extra.where("date = ? AND start_time < ? AND end_time > ? AND id <> ? AND room_id = ?", @start_date, @end_time, @start_time, @lesson_id, @room_id)  
   
   if @extras_room_conflicts.any?
     @extras_room_conflicts.each do |extra|
       @comp_id = extra.id.to_s + "-Extra"
       @scheduled_conflict = Lesson.new(comp_id: @comp_id, room_id: extra.room_id, instrument_id: extra.instrument_id, student_id: extra.student_id, start_date: extra.date, start_time: extra.start_time, end_time: extra.end_time, weekday: extra.date.wday)
       @room_conflicts = @room_conflicts.push(@scheduled_conflict)
     end
   end

   if @room_conflicts.any?
     @room_conflicts.each do |lesson|
       @id = lesson.comp_id.split('-')[0].to_i
       @attendable_type = lesson.comp_id.split('-')[1]
       @opening = Attendance.where("attendable_id = ? AND attendable_type = ? AND status = ? AND date = ?", @id, @attendable_type, "c", @start_date ).first

        if @opening
          @room_conflicts.delete_if{|k, v| k.comp_id.split('-')[0].to_i == @opening.attendable_id}
        end
     end
   end
   
   if @room_conflicts.any?     
     @room_conflict = @room_conflicts.first
     @student = Student.find(@room_conflict.student_id)
     if @room_conflict.comp_id.split('-')[1] == "Lesson" or @room_conflict.comp_id.nil?
       @type = "Regular Lesson"
     elsif @room_conflict.comp_id.split('-')[1] == "Extra"
       @id = @room_conflict.comp_id.split('-')[0].to_i
       @category_code = Extra.find(@id).category
       @type = view_context.extra_category_description(@category_code)
     end
   end
   
    render :layout => false
  end
  
end
