class CreateExtras < ActiveRecord::Migration
  def change
    create_table :extras do |t|
      t.integer :student_id
      t.integer :teacher_id
      t.integer :instrument_id
      t.integer :room_id
      t.date :date
      t.time :start_time
      t.time :end_time
      t.string :category

      t.timestamps
    end
  end
end
  