class Lesson < ActiveRecord::Base
  attr_accessible :end_date, :end_time, :frequency, :instrument_id, :start_date, :start_time, :student_id, :teacher_id, :weekday
end
