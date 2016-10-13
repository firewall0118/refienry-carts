class CreateCartsCarts < ActiveRecord::Migration

  def up
    create_table :refinery_carts do |t|
      t.references :user
      t.string :discount_code
      t.integer :position
      t.boolean :paid, default: false
      t.boolean :shipped, default: false

      t.timestamps
    end
    add_index :refinery_carts, :user_id
  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-carts"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/carts/carts"})
    end

    drop_table :refinery_carts

  end

end
