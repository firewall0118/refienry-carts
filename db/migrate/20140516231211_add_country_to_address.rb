class AddCountryToAddress < ActiveRecord::Migration
  def change
    add_column :refinery_carts_addresses, :country, :string, default: 'United States'
    add_column :refinery_carts_addresses, :billing, :boolean, default: false
    change_column :refinery_carts_addresses, :zip, :string #for non-us addr
  end
end
