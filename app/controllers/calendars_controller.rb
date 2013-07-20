class CalendarsController < ApplicationController
  layout "calendars"
  def daily
    
    if params[:teacher_id]
      @teacher = Teacher.find(params[:teacher_id])
    end
    
    @rooms = Room.find(:all, :order => "id ASC")
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
    
    if @teacher != nil
      @lessons = @teacher.lessons.where("weekday = ? AND start_date <= ? AND (end_date >= ? OR end_date IS NULL)", @day_of_week, @date, @date).order("start_time ASC, end_time ASC")
    else
      @lessons = Lesson.where("weekday = ? AND start_date <= ? AND (end_date >= ? OR end_date IS NULL)", @day_of_week, @date, @date).order("start_time ASC, end_time ASC")
    end
    
    @lessons.each do |lesson|
      lesson.comp_id = lesson.id.to_s + "-lesson"
    end
    
    @attendances = Attendance.where("date = ?", @date.to_date)
    
    if @attendances.any?
      @attendances.each do |attendance|
        case attendance.attendable_type
        when "Lesson"
          @lesson_index = @lessons.find_index{|n| n['id'] == attendance.attendable_id }
          if @lesson_index
            @lessons[@lesson_index].status = attendance.status
          end
          
        
        when "Extra"
          @extra = Extra.find(attendance.attendable_id)
          @extra_lesson = Lesson.new(comp_id: @extra.id.to_s + "-extra", student_id: @extra.student_id, teacher_id: @extra.teacher_id, room_id: @extra.room_id, start_time: @extra.start_time, end_time: @extra.end_time, status: attendance.status)
          @lessons.push(@extra_lesson)
        end
      end
    end
  end
end
