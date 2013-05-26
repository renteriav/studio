class CalendarsController < ApplicationController
  layout "calendars"
  def daily
    
    @lessons = Lesson.all
    if params[:teacher_id]
      @teacher = Teacher.find(params[:teacher_id])
    end
    
    @rooms = Room.all
    
    if params[:date]
      @date = Time.at((params[:date]).to_i)
    else
      @date = Time.now
    end
    @day =  @date.strftime("%A, %b #{@date.day.ordinalize}, %Y")
    gon.date = @date.strftime('%m/%d/%Y')
    @previous = (@date - (24*60*60)).strftime('%s')
    @next = (@date + (24*60*60)).strftime('%s')
  end
end