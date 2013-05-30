# == Schema Information
#
# Table name: lessons
#
#  id            :integer          not null, primary key
#  student_id    :integer
#  teacher_id    :integer
#  instrument_id :integer
#  room_id       :integer
#  weekday       :integer
#  start_time    :time
#  end_time      :time
#  frequency     :integer
#  start_date    :date
#  end_date      :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Lesson < ActiveRecord::Base
  
  belongs_to :student
  belongs_to :teacher
  
  attr_accessible :end_date, :end_time, :frequency, :instrument_id, :room_id, :start_date, :start_time, :student_id, :teacher_id, :weekday
end
