class CalendarsController < ApplicationController
  layout "calendars"
  def daily
    
    if params[:teacher_id]
      @teacher = Teacher.find(params[:teacher_id])
    end
    
    @rooms = Room.find(:all, :order => "id ASC")
    
    if params[:date]
      @date = Time.at((params[:date]).to_i).midnight
    else
      @date = Time.now.midnight
    end
    gon.date = @date.strftime('%m/%d/%Y')
    @day =  @date.strftime("%A, %b #{@date.day.ordinalize}, %Y")
    
    @previous = (@date - (24*60*60)).to_i
    @next = (@date + (24*60*60)).to_i
    @day_of_week = @date.wday
    @sunday = @date - (@day_of_week*24*60*60)
    
    @lessons = Lesson.where("weekday = ? AND start_date <= ? AND (end_date >= ? OR end_date IS NULL)", @day_of_week, @date, @date).order("start_time ASC, end_time ASC")
    
    @attendances = Attendance.where("date = ?", @date.to_date)
    
    if @attendances.any?
      @attendances.each do |attendance|
        @lesson_index = @lessons.find_index{|n| n['id'] == attendance.attendable_id }
        @lessons[@lesson_index].status = attendance.status
      end
    end
    
    @num_rooms = 8
    @num_rows = 56
    @first_slot_time = Time.utc(2000,1,1,6,0,0)
    
  end
end
