class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :attendable_id
      t.string :attendable_type
      t.date :date
      t.string :status

      t.timestamps
    end
  end
end
  
