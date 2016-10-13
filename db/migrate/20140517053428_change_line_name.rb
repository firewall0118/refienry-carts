class ChangeLineName < ActiveRecord::Migration
  def change
    rename_column :refinery_carts_addresses, :address1, :line_1
    rename_column :refinery_carts_addresses, :address2, :line_2
  end

end
