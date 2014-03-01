module StudentsHelper
  
  def school_grades
      [
        ['Kinder', 0],
        ['1st', 1],
        ['2nd', 2],
        ['3rd', 3],
        ['4th', 4],
        ['5th', 5],
        ['6th', 6],
        ['7th', 7],
        ['8th', 8],
        ['9th', 9],
        ['10th', 10],
        ['11th', 11],
        ['12th', 12]
      ]
  end
  
  def grade_display
    a = school_grades
    b = Array.new
    a.each do |key, value|
      b.push(key)
    end
    return b
  end
  
  def current_grade(year, grade)
    a = Time.now.year - year
    Time.now.month < 8 ? b = 1: b = 0
    @current_grade = grade + a - b
    return @current_grade
  end
  
  def month_lessons(lesson, date)
  	@lesson_weekday = lesson.weekday
  	@month_first_wday = date.wday
  	@days_apart = @lesson_weekday - @month_first_wday
  	@first_lesson_of_month = date + @days_apart
  	@lesson_date = @first_lesson_of_month
  	while @lesson_date < date or @lesson_date < lesson.start_date do
  		@lesson_date += 7
  	end
    
    @sharings = Sharing.where("date >= ? AND date <= ?", date, date.end_of_month).order("date ASC")
    @sharings_dates = Array.new
    @sharings.each do |sharing|
      @sharings_dates.push(sharing.date)
    end
	
  	@month_lessons = Array.new
  	while @lesson_date <= @date.end_of_month do
     unless @sharings_dates.include?(@lesson_date)
  		  @attendance = Attendance.new
        @attendance.teacher_id = lesson.teacher_id
        @attendance.date = @lesson_date
        @attendance.status = "s"
  		  @month_lessons.push(@attendance)
     end
     @lesson_date += 7
  	end
    
  	@attendances = lesson.attendances.where("date >= ? AND date <= ?", date, date.end_of_month).order("date ASC")
  	@attendances.each do |attendance|
  		@attendance_index = @month_lessons.find_index{|n| n['date'] == attendance.date }
          if @attendance_index
        		@lesson_time = join_date_time(attendance.date, lesson.end_time)
        		if @lesson_time < Time.now
        		  if attendance.status == "s" 
        		    attendance.status = "u"
              end
        		end
            @month_lessons[@attendance_index] = attendance
          end
  	end
    
    return @month_lessons
  end
  
end