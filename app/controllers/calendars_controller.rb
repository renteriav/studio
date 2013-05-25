class CalendarsController < ApplicationController
  layout "calendars"
  def daily
    
    @lessons = Lesson.all
    if params[:teacher_id]
      @teacher = Teacher.find(params[:teacher_id])
    end
    
    @rooms = Room.all
    
    @date = Time.now
    @day =  @date.strftime('%A, %b %e, %Y')
  end
end