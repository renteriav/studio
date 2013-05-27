class CalendarsController < ApplicationController
  layout "calendars"
  def daily
    
    @lessons = Lesson.all
    if params[:teacher_id]
      @teacher = Teacher.find(params[:teacher_id])
    end
    
    @rooms = Room.all
    
    if params[:date]
      @date = Time.at((params[:date]).to_i).midnight
    else
      @date = Time.now.midnight
    end
    gon.date = @date.strftime('%m/%d/%Y')
    @day =  @date.strftime("%A, %b #{@date.day.ordinalize}, %Y")
    
    @num_rooms = 8
    @num_rows = 56
    @first_slot_time = Time.utc(2000,1,1,6,0,0)
    
    @previous = (@date - (24*60*60)).to_i
    @next = (@date + (24*60*60)).to_i
    @day_of_week = @date.wday
    @sunday = @date - (@day_of_week*24*60*60)
    
    @lessons = Lesson.where("weekday = ? AND start_date <= ? AND (end_date >= ? OR end_date IS NULL)", @day_of_week, @date, @date).order("start_time ASC, end_time ASC")
    
#  @columns is an array of lessons for each room for the selected day.
    
    @columns = Array.new
    @rooms.each do |room|
      @columns[room.id] = Array.new
    end

    if @lessons
      @lessons.each do |lesson|
        @start_time = lesson.start_time
        @end_time = lesson.end_time
        @room = lesson.room_id
        @lesson_length = (@end_time - @start_time)/60/15
        @slot_number = (@start_time - @first_slot_time)/60/15
      
        @columns[@room].push({ 
          :id => lesson.id, 
          :room => @room, 
          :teacher => lesson.teacher_id, 
          :start_time => @start_time, 
          :end_time => @end_time, 
          :slot => @slot_number,  
          :length => @lesson_length })
      end
    end
    
#  @slot contains an array of lessons for each slot.
    
    @slot = Array.new
    @rooms.each do |room|
      @slot[room.id] = Array.new(@num_rows){Array.new}
    end
    
    if @columns
      @columns.each do |column|
        if column != nil
          i = 0
          while i < column.count do
            t = 0
            while t < column[i][:length] do
              @number = column[i][:slot] + t
              @room = column[i][:room]
              @slot[@room][@number].push(column[i][:id])
              t += 1
            end
            i += 1
          end
        end
      end
    end
    
#  @max_num is an array of max number of conflicts for each lesson for each room.

    @max_num = Array.new
    @rooms.each do |room|
      @max_num[room.id] = Hash.new
    end
    
    d = 0
    while d < @num_rooms
      if @columns[d] != nil
        @columns[d].each do |column|
          i = 0
          while i < column[:length]
            @slot_number = column[:slot]
            @keys = @slot[d][@slot_number].count
            @keys_next = @slot[d][@slot_number + i].count
            @lesson_id = column[:id]
            @max_num[d].merge!({@lesson_id => @keys})
            if @keys_next > @max_num[d][@lesson_id]
              t = 0
              while t < column[:length]
                @slot[d][@slot_number + t].each do |event|
                  @max_num[d][event] = @keys_next
                end
                t += 1
              end
            end
            i += 1
          end
        end
      end
      d += 1
    end
    
#  fine tune the graph and loops twice to correct problems   
    t = 0
    while t < 2 do
      d = 0
      while d < @num_rooms do
        if @slot[d] != nil
          i = 0
          while i < @num_rows do
            @max = 0
            if @slot[d][i] != nil
              @slot[d][i].each do |lesson_id|
                @new_max = @max_num[d][lesson_id]
                if @new_max > @max
                  @max = @new_max
                end
              end
              @slot[d][i].each do |lesson_id|
                @max_num[d][lesson_id] = @max
              end
            end
            i += 1
          end
        end
        d += 1
      end
      t += 1
    end
    
  end
end







