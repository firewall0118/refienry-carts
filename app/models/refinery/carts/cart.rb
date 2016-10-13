module Refinery
  module Carts
    class Cart < Refinery::Core::BaseModel
      self.table_name = 'refinery_carts'
      belongs_to :user, class_name: Refinery::User
      has_many :line_items
      has_one :order
      attr_accessible :user, :discount_code, :position, :ship_all, :item
      attr_accessor :discount_code, :ship_all, :item

      def calculate_tax
        0
      end
      
      def discount
        0
      end

      def empty?
        size == 0
      end

      # This will be overridden by a cart_decorator to find and return the user's credit card. Probably want to incorporate credit card storage into the cart like
      # Addresses. It would seem like it would make sense across projects. TODO
      def get_credit_card
      end      

      def item=(product_id)
        # find an existing line_item with the same product_id. If found, increment the quantity
        line_item = line_items.where(product_id: product_id).first
        if line_item
          line_item.increment! :qty
        else
          line_items.create product_id: product_id
        end
      end

      def ready_to_ship?
        line_items.any? && line_items.all?{|li| li.address_id }
      end

      def shipping
        0
      end
      
      def ship_all=(address_id)
        errors.add(:base, 'no such address') and return unless address = find_address(address_id)
        address.update_attribute :default, true
        line_items.each do |li|
          li.update_attribute :address_id, address_id
        end
      end

      def size
        line_items.count
      end

      def subtotal
        line_items.sum(&:price)
      end
      
      def total
        subtotal + shipping + tax - discount
      end

      private

        def find_address(address_id)
          user.addresses.find(address_id)
        end
    end
  end
end
