class AddGiftToRefineryCartsLineItems < ActiveRecord::Migration
  def change
    add_column :refinery_carts_line_items, :gift, :boolean, default: false
    add_column :refinery_carts_line_items, :gift_message, :string
  end
end
