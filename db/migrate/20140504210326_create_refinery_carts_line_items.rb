class CreateRefineryCartsLineItems < ActiveRecord::Migration
  def change
    create_table :refinery_carts_line_items do |t|
      t.references :cart
      t.string :product_id
      t.string :description
      t.integer :qty
      t.decimal :unit_price, :precision => 6, :scale => 2
      t.boolean :virtual, default: false
      t.references :address
      t.boolean :shipped, default: false

      t.timestamps
    end
    add_index :refinery_carts_line_items, :cart_id
    add_index :refinery_carts_line_items, :address_id
  end
end
