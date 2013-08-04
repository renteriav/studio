class CreateDetailedSharing < ActiveRecord::Migration
  def change
    create_table :detailed_sharings do |t|
      t.integer :student_id
      t.integer :sharing_id
      t.boolean :attendance
      t.boolean :memory
      t.boolean :practice

      t.timestamps
    end
  end
end
 