class AddDefaultToAddresses < ActiveRecord::Migration
  def change
    add_column :refinery_carts_addresses, :default, :boolean, default: false
  end
end
