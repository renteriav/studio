class CreateSharingTeacherJoinTable < ActiveRecord::Migration
  def change
      create_table :sharings_teachers, :id => false do |t|
        t.integer :sharing_id
        t.integer :teacher_id
      end
    end
  end
