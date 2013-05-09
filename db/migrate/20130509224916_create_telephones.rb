class CreateTelephones < ActiveRecord::Migration
  def change
    create_table :telephones do |t|
      t.string :area
      t.string :sufix
      t.string :prefix
      t.string :description
      t.integer :customer_id

      t.timestamps
    end
  end
end
