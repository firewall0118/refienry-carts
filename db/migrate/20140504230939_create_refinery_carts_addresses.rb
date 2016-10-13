class CreateRefineryCartsAddresses < ActiveRecord::Migration
  def change
    create_table :refinery_carts_addresses do |t|
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state, :limit => 2
      t.integer :zip, :limit => 5
      t.references :user

      t.timestamps
    end
    add_index :refinery_carts_addresses, :user_id
  end
end
