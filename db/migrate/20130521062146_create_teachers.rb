class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :first
      t.string :last
      t.string :email
      t.string :status
      t.timestamps
    end
  end
end
