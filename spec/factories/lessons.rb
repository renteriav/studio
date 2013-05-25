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
