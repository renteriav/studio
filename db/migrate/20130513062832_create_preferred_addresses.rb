class CreatePreferredAddresses < ActiveRecord::Migration
  def change
    create_table :preferred_addresses do |t|
      t.integer :address_id
      t.string :description

      t.timestamps
    end
  end
end
