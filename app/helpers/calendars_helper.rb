module CalendarsHelper
  
  def prerender_calendar(lessons, rooms, num_rooms, num_rows, first_slot_time)
    
#  @columns is an array of lessons for each room for the selected day.
    
    @columns = Array.new
    rooms.each do |room|
      @columns[room.id] = Array.new
    end

    if lessons
      lessons.each do |lesson|
        @start_time = lesson.start_time
        @end_time = lesson.end_time
        @room = lesson.room_id
        @lesson_length = (@end_time - @start_time)/60/15
        @slot_number = (@start_time - first_slot_time)/60/15
        lesson.status.nil? ? @status = "s" : @status = lesson.status
        lesson.student_id.nil? ? @student = "" : @student = "#{lesson.student.first.first}. #{lesson.student.last}"
        
        if lesson.status == "sh"
          @teacher = "SHARING"
        else
        lesson.teacher_id.nil? ? @teacher = "Need Sub" : @teacher = lesson.teacher.first
        end
      
      
        @columns[@room].push({ 
          :id => lesson.comp_id, 
          :room => @room, 
          :teacher => @teacher,
          :student => @student, 
          :start_time => @start_time, 
          :end_time => @end_time, 
          :slot => @slot_number,  
          :length => @lesson_length,
          :status => @status }) #  default is (s = scheduled)
      end
    end
    
#  @slot contains an array of lessons for each slot.
    
    @slot = Array.new
    rooms.each do |room|
      @slot[room.id] = Array.new(num_rows){Array.new}
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
    rooms.each do |room|
      @max_num[room.id] = Hash.new
    end
    
    d = 0
    while d < num_rooms
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
      while d < num_rooms do
        if @slot[d] != nil
          i = 0
          while i < num_rows do
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
    
#  makes an array of index for each event. The index is the position in which 
#  an event is placed in the calendar from left to right.
   
    @index = Array.new
    @index_array = Array.new
    rooms.each do |room|
      @index_array[room.id] = Hash.new
    end
    d = 0
    while d < num_rooms do
      if @slot[d] != nil
        sl = 0
        while sl < num_rows do
          @keys = @slot[d][sl].count
          @prev = @slot[d][sl - 1]
          @index.clear
          if @prev
            i = 0
            while i < @keys do
              if @prev.include?(@slot[d][sl][i]) 
                @index.push(@index_array[d][@slot[d][sl][i]])
              else
                if @index.empty?
                  @counter = 0
                  @slot[d][sl].each do |event|
                    @index_array[d].merge!(event => @counter)
                    @counter += 1
                  end
                else
                  @index.sort! {|x,y| x <=> y }
                  @counter = 0
                  while @index[@counter] == @counter do
                    @counter += 1
                  end
                  @index_array[d][@slot[d][sl][i]] = @counter
                  @index.push(@counter) 
                end
              end
              i += 1
            end
          else
            @counter = 0
            if @slot[d][sl] != nil
              @slot[d][sl].each do |event|
                @index_array[d].merge!(event => @counter)
                @counter += 1
              end
            end
          end
          sl += 1
        end
      end
      d += 1
    end
    
#  makes an array with the ids and indexes of lessons per slot ordered by index
    
    @event_index = Array.new
    rooms.each do |room|
      @event_index[room.id] = Array.new(num_rows){Array.new}
    end
    
    d = 0
    while d < num_rooms do
      i = 0
      if @slot[d] != nil
        while i < num_rows do
          if @slot[d][i] != nil 
            @slot[d][i].each do |id|
              @event_index[d][i].push({:index=>@index_array[d][id], :id => id})
              @event_index[d][i].sort! {|a,b| a[:index] <=> b[:index]}
            end
          end
          i += 1
        end
      end
      d += 1
    end
    
# Calculates when an event needs more than 1 space.
    @num_slots = Hash.new
    d = 0
    while d < num_rows
      if @columns[d] != nil
        	@columns[d].each do |column|
        	@num_slots.merge!(column[:id] => @max_num[d][column[:id]] - @index_array[d][column[:id]])
        end
        sl = 0
        while sl < num_rows do
        	if @event_index[d][sl] != nil
        		@num_events = @event_index[d][sl].count
            i = 0
        		while i < (@num_events - 1) do
        			@ind = @event_index[d][sl][i][:index]
        			@next_ind = @event_index[d][sl][i+1][:index]
        			@event_id = @event_index[d][sl][i][:id]
        			@result = @next_ind - @ind
        			if @num_slots[@event_id] != nil
                if @num_slots[@event_id] > @result
        						@num_slots[@event_id] = @result
                end
              end
              i += 1
            end
          end
        sl += 1
        end
      end
      d += 1
    end
  end
    
    def prerender_weekly_calendar(lessons, num_columns, num_rows, first_slot_time)
    
  #  @columns is an array of lessons for each day.
    
      @columns = Array.new
      d = 0
      while d < num_columns do
        @columns[d] = Array.new
        d += 1
      end

      if lessons
        lessons.each do |lesson|
          @start_time = lesson.start_time
          @end_time = lesson.end_time
          @day_of_week = lesson.weekday
          @room = Room.find(lesson.room_id).name
          @lesson_length = (@end_time - @start_time)/60/15
          @slot_number = (@start_time - first_slot_time)/60/15
          lesson.status.nil? ? @status = "s" : @status = lesson.status
          lesson.student_id.nil? ? @student = "" : @student = "#{lesson.student.first.first}. #{lesson.student.last}"
        
          if lesson.status == "sh"
            @student = "SHARING"
          else
          lesson.teacher_id.nil? ? @teacher_name = "Need Sub" : @teacher_name = lesson.teacher.first
          end
      
      
          @columns[@day_of_week].push({ 
            :id => lesson.comp_id,
            :weekday => lesson.weekday,
            :room => @room, 
            :teacher => @teacher_name,
            :student => @student, 
            :start_time => @start_time, 
            :end_time => @end_time, 
            :slot => @slot_number,  
            :length => @lesson_length,
            :status => @status }) #  default is (s = scheduled)
        end
      end
    
  #  @slot contains an array of lessons for each slot.
    
      @slot = Array.new
      d = 0
      while d < num_columns do
        @slot[d] = Array.new(num_rows){Array.new}
        d += 1
      end
    
      if @columns
        @columns.each do |column|
          if column != nil
            i = 0
            while i < column.count do
              t = 0
              while t < column[i][:length] do
                @number = column[i][:slot] + t
                #@room = column[i][:room]
                @weekday = column[i][:weekday]
                @slot[@weekday][@number].push(column[i][:id])
                t += 1
              end
              i += 1
            end
          end
        end
      end
    
  #  @max_num is an array of max number of conflicts for each lesson for each room.

      @max_num = Array.new
      d = 0
      while d < num_columns do
        @max_num[d] = Hash.new
        d += 1
      end
    
      d = 0
      while d < num_columns do
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
        while d < num_columns do
          if @slot[d] != nil
            i = 0
            while i < num_rows do
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
    
  #  makes an array of index for each event. The index is the position in which 
  #  an event is placed in the calendar from left to right.
   
      @index = Array.new
      @index_array = Array.new
      d = 0
      while d < num_columns do
        @index_array[d] = Hash.new
        d += 1
      end
      d = 0
      while d < num_columns do
        if @slot[d] != nil
          sl = 0
          while sl < num_rows do
            @keys = @slot[d][sl].count
            @prev = @slot[d][sl - 1]
            @index.clear
            if @prev
              i = 0
              while i < @keys do
                if @prev.include?(@slot[d][sl][i]) 
                  @index.push(@index_array[d][@slot[d][sl][i]])
                else
                  if @index.empty?
                    @counter = 0
                    @slot[d][sl].each do |event|
                      @index_array[d].merge!(event => @counter)
                      @counter += 1
                    end
                  else
                    @index.sort! {|x,y| x <=> y }
                    @counter = 0
                    while @index[@counter] == @counter do
                      @counter += 1
                    end
                    @index_array[d][@slot[d][sl][i]] = @counter
                    @index.push(@counter) 
                  end
                end
                i += 1
              end
            else
              @counter = 0
              if @slot[d][sl] != nil
                @slot[d][sl].each do |event|
                  @index_array[d].merge!(event => @counter)
                  @counter += 1
                end
              end
            end
            sl += 1
          end
        end
        d += 1
      end
    
  #  makes an array with the ids and indexes of lessons per slot ordered by index
    
      @event_index = Array.new
      d = 0
      while d < num_columns do
        @event_index[d] = Array.new(num_rows){Array.new}
        d += 1
      end
    
      d = 0
      while d < num_columns do
        i = 0
        if @slot[d] != nil
          while i < num_rows do
            if @slot[d][i] != nil 
              @slot[d][i].each do |id|
                @event_index[d][i].push({:index=>@index_array[d][id], :id => id})
                @event_index[d][i].sort! {|a,b| a[:index] <=> b[:index]}
              end
            end
            i += 1
          end
        end
        d += 1
      end
    
  # Calculates when an event needs more than 1 space.
      @num_slots = Hash.new
      d = 0
      while d < num_rows
        if @columns[d] != nil
          	@columns[d].each do |column|
          	@num_slots.merge!(column[:id] => @max_num[d][column[:id]] - @index_array[d][column[:id]])
          end
          sl = 0
          while sl < num_rows do
          	if @event_index[d][sl] != nil
          		@num_events = @event_index[d][sl].count
              i = 0
          		while i < (@num_events - 1) do
          			@ind = @event_index[d][sl][i][:index]
          			@next_ind = @event_index[d][sl][i+1][:index]
          			@event_id = @event_index[d][sl][i][:id]
          			@result = @next_ind - @ind
          			if @num_slots[@event_id] != nil
                  if @num_slots[@event_id] > @result
          						@num_slots[@event_id] = @result
                  end
                end
                i += 1
              end
            end
          sl += 1
          end
        end
        d += 1
      end
    end
      
    def event_color(status)
      case status
      when "s" # scheduled
        0XACCFFC
      when "c" # canceled
        0XFFFF99
      when "a" #attended
        0x66EE60
      when "m" #missed
        0XFF1050
      when "sh" #sharing
        0XFF50AA
      end
    end
    
    def lesson_category_decoder(comp_id)
       split_id = comp_id.split("-")
       id = split_id[0]
       category = split_id[1]
       case category
       when "lesson"
         "Regular Lesson"
       when "extra"
         extra_category_description(Extra.find(id).category)
       when "out"
         "Not Teaching"
       when "sub"
         "subbing"
       end      
    end  
  
end
	