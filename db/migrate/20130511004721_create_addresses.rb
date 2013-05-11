class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :customer_id
      t.string :address_id
      t.string :description
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
