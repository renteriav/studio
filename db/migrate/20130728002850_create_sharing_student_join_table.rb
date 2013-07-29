class CreateSharingStudentJoinTable < ActiveRecord::Migration
  def change
      create_table :sharings_students, :id => false do |t|
        t.integer :sharing_id
        t.integer :student_id
      end
    end
  end
  