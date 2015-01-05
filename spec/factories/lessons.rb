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

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lesson do
    student_id 1
    teacher_id 1
    instrument_id 1
    weekday 1
    start_time "2013-05-22 20:51:04"
    end_time "2013-05-22 20:51:04"
    frequency 1
    start_date "2013-05-22"
    end_date "2013-05-22"
  end
end
