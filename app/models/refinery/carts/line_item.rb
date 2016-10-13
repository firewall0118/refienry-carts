module Refinery
  module Carts
    class LineItem < Refinery::Core::BaseModel
      belongs_to :cart
      delegate :user, to: :cart
      belongs_to :address
      attr_accessible :product_id, :description, :qty, :unit_price, :virtual, :shipped, :address_id, :gift, :gift_message
      before_create :set_address
      before_save :set_description, :set_unit_price

      def price
        qty * unit_price
      end
      private

        def set_address
          #default_address = Address.where(user_id: user.id, default: true).first
          self.address = user.default_shipping_address
        end

        # These are separate methods because the product_id, description, and unit price could be in different fields depending on the project. Each project must 
        # define how to obtain these values for the line item with a line_item_decorator
        def set_description
          self.description = _set_description
        end

        def set_unit_price
          self.unit_price = _set_unit_price
        end

    end
  end
end
