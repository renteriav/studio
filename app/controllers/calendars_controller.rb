class CalendarsController < ApplicationController
  before_action :authenticate_user!
  before_filter :check_for_mobile
  allow_oauth!
  #layout "calendars"
  def daily
    
    if current_user
      if current_user.loginable_type == "Teacher"
        @teacher = Teacher.find(current_user.loginable_id)
      end
    end
    
    @rooms = Room.all.order("id ASC")
    @num_rooms = Room.count
    @num_rows = 56
    @first_slot_time = Time.utc(2000,1,1,6,0,0)

    if params[:date]
      @date = Time.at((params[:date]).to_i).midnight
    else
      @date = Time.now.midnight
    end
    gon.date = @date.strftime('%m/%d/%Y')
    gon.ruby_date = @date.strftime('%d/%m/%Y')
    @day =  view_context.format_day(@date)
    @previous = (@date - (24*60*60)).to_i
    @next = (@date + (24*60*60)).to_i
    @day_of_week = @date.wday
    @sunday = @date - (@day_of_week*24*60*60)
    
    @sharing = Sharing.where("date = ?", @date.to_date)
    
    if @sharing.any? 
      @sharing.each do |sharing|
      sharing.comp_id = sharing.id.to_s + "-sharing"
      sharing.room_id = 1
      sharing.status = "sh"
      end
      @lessons = @sharing
      
    else
      if @teacher #!= nil
      @lessons = @teacher.lessons.where("weekday = ? AND start_date <= ? AND (end_date >= ? OR end_date IS NULL)", @day_of_week, @date, @date).order("start_time ASC, end_time ASC")
      else
      @lessons = Lesson.where("weekday = ? AND start_date <= ? AND (end_date >= ? OR end_date IS NULL)", @day_of_week, @date, @date).order("start_time ASC, end_time ASC")
      end
    
      @lessons.each do |lesson|
      lesson.comp_id = lesson.id.to_s + "-lesson"
      end
    end
    
    if @teacher != nil
      @attendances = Attendance.where("date = ? AND teacher_id=?", @date.to_date, @teacher.id)
    else
      @attendances = Attendance.where("date = ?", @date.to_date )  
    end
    if @attendances.any?
      @attendances.each do |attendance|
        case attendance.attendable_type
        when "Lesson"
          @lesson_index = @lessons.find_index{|n| n['id'] == attendance.attendable_id }
          if @lesson_index
           @lessons[@lesson_index].status = attendance.status
           @lessons[@lesson_index].teacher_id = attendance.teacher_id
          else
            @lesson = Lesson.find(attendance.attendable_id)
            @sub_lesson = Lesson.new(comp_id: @lesson.id.to_s + "-lesson", student_id: @lesson.student_id, teacher_id: attendance.teacher_id, room_id: @lesson.room_id, start_time: @lesson.start_time, end_time: @lesson.end_time, status: attendance.status)
            @lessons = @lessons.to_a.push(@sub_lesson)
          end
                 
        when "Extra"
          @extra = Extra.find(attendance.attendable_id)
          @extra_lesson = Lesson.new(comp_id: @extra.id.to_s + "-extra", student_id: @extra.student_id, teacher_id: @extra.teacher_id, room_id: @extra.room_id, start_time: @extra.start_time, end_time: @extra.end_time, status: attendance.status)
          @lessons = @lessons.to_a.push(@extra_lesson)
        end
      end
    end
    @lessons_remote = Array.new
    @lessons.each do |lesson|
      @student = Student.find(lesson.student_id)
      @student_name = @student.first + " " + @student.last.first + "."
      @start_time = view_context.format_time_short(lesson.start_time)
      lesson.status.nil? ? @status = view_context.status_name("s", "plain") : @status = view_context.status_name(lesson.status, "plain")
      @lesson_hash = Hash.new
      @lesson_hash["student"] = @student_name
      @lesson_hash["status"] = @status
      @lesson_hash["start_time"] = @start_time
      @lessons_remote.push(@lesson_hash)
    end
    respond_to do |format|
      format.html
      format.json { render :json => @lessons_remote }
    end
      
      
  end
  
  def weekly
    @teacher = Teacher.find(params[:teacher_id])
    @num_columns = 7
    @num_rows = 56
    @first_slot_time = Time.utc(2000,1,1,6,0,0)
    
    if params[:date]
      @date = Time.at((params[:date]).to_i).beginning_of_week(start_day = :sunday)
    else
      @date = Time.now.beginning_of_week(start_day = :sunday)
    end
    @this_week = @date.to_date
    @next_week = @date.to_date + 7
    gon.date = @date.strftime('%m/%d/%Y')
    gon.ruby_date = @date.strftime('%d/%m/%Y')
    @previous = (@date - (24*60*60*7)).to_i
    @next = (@date + (24*60*60*7)).to_i
    @lessons = Array.new
    
    @sharing = Sharing.where("date >= ? AND date < ?", @date.to_date, @next_week )
    
    if @sharing.any? 
      @sharing.each do |sharing|
      
      @sharing_lesson = Lesson.new(comp_id: sharing.id.to_s + "-sharing", room_id: 1, start_time: sharing.start_time, end_time: sharing.end_time, weekday: sharing.date.wday, status: "sh")
      @lessons = @lessons.to_a.push(@sharing_lesson)
      end
    end
    
    @regular_lessons = @teacher.lessons.where("start_date < ? AND (end_date > ? OR end_date IS NULL)", @next_week, @next_week).order("start_time ASC, end_time ASC")
    
    if @regular_lessons   
      @regular_lessons.delete_if{|x| (x.weekday > x.end_date.wday && x.end_date < @next_week) unless x.end_date.nil?}
      @regular_lessons.delete_if{|x| x.weekday < x.start_date.wday && x.start_date > @this_week }
      
      if @lessons 
        @lessons.each do |sharing|
          @regular_lessons.delete_if{|x| sharing.weekday == x.weekday}
        end
      end
      
      if @regular_lessons
        @regular_lessons.each do |lesson|
          @not_in = Attendance.where("attendable_type = ? AND attendable_id = ? AND date >= ? AND date < ? AND teacher_id <> ?", "Lesson", lesson.id, @this_week, @next_week, @teacher.id).first
          if @not_in
            lesson.comp_id = lesson.id.to_s + "-out"
            lesson.teacher_id = @not_in.teacher_id
            lesson.status = @not_in.status
          else
              lesson.comp_id = lesson.id.to_s + "-lesson"
          end
          @lessons = @lessons.push(lesson)
        end
      end
    end
        
      @attendances = Attendance.where("date >= ? AND date < ? AND teacher_id = ?", @this_week, @next_week, @teacher.id)
    
    if @attendances.any?
      @attendances.each do |attendance|
        case attendance.attendable_type
        when "Lesson"
          @lesson_index = @lessons.find_index{|n| n.id == attendance.attendable_id && n.comp_id.split('-')[1] == "lesson" }
          if @lesson_index
            @lessons[@lesson_index].status = attendance.status
            @lessons[@lesson_index].teacher_id = attendance.teacher_id
          else
            @lesson = Lesson.find(attendance.attendable_id)
            @sub_lesson = Lesson.new(comp_id: @lesson.id.to_s + "-sub", student_id: @lesson.student_id, teacher_id: @lesson.teacher_id, room_id: @lesson.room_id, instrument_id: @lesson.instrument_id, start_time: @lesson.start_time, end_time: @lesson.end_time, weekday: @lesson.weekday, status: attendance.status)
            @lessons = @lessons.to_a.push(@sub_lesson)
          end
        
        when "Extra"
          @extra = Extra.find(attendance.attendable_id)
          @extra_lesson = Lesson.new(comp_id: @extra.id.to_s + "-extra", student_id: @extra.student_id, teacher_id: @extra.teacher_id, room_id: @extra.room_id, instrument_id: @extra.instrument_id, start_time: @extra.start_time, end_time: @extra.end_time, weekday: @extra.date.wday, status: attendance.status)
          @lessons = @lessons.to_a.push(@extra_lesson)
        end
      end
    end
    respond_to do |format|
      format.html
      format.json { render :json => @lessons }
    end
  end
  
end
