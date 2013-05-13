class CreateTelephones < ActiveRecord::Migration
  def change
    create_table :telephones do |t|
      t.string :area
      t.string :prefix
      t.string :sufix
      t.string :description
      t.integer :phoneable_id
      t.string :phoneable_type

      t.timestamps
    end
  end
end
