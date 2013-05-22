class CreateInstrumentTeacherJoinTable < ActiveRecord::Migration
  def change
      create_table :instruments_teachers, :id => false do |t|
        t.integer :instrument_id
        t.integer :teacher_id
      end
    end
  end
