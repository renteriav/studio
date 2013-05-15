class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string :first
      t.string :last
      t.string :cell
      t.string :email
      t.date :birthdate
      t.integer :grade
      t.integer :customer_id
      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
