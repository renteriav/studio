class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :student_id
      t.integer :teacher_id
      t.integer :instrument_id
      t.integer :room_id
      t.integer :weekday
      t.time :start_time
      t.time :end_time
      t.integer :frequency
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
