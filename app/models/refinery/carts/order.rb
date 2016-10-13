module Refinery
  module Carts
    class Order < Refinery::Core::BaseModel
      self.table_name = 'refinery_orders'
      belongs_to :user, class_name: Refinery::User
      belongs_to :cart
      belongs_to :address
      has_many :line_items, through: :cart

      
      attr_accessor :credit_card_name, :credit_card_number, :cc_expiration_month, 
                    :cc_expiration_year, :cvv
      attr_accessible :user, :discount_code, :credit_card_name, :credit_card_number, 
                      :cc_expiration_month, :cc_expiration_year, :cvv, :confirmation_number,
                      :address_id
      
      before_create :mark_cart_paid, :set_user, :set_confirmation_number

      # This will be overridden by a cart_decorator to find and return the user's credit card. Probably want to incorporate credit card storage into the cart like
      # Addresses. It would seem like it would make sense across projects. TODO
      def get_credit_card
      end      

      
      def to_param
        confirmation_number
      end

      private

        def mark_cart_paid
          cart.paid = true
          cart.save
        end

        def set_confirmation_number
          self.confirmation_number = "#{Time.now.to_i}-#{rand(10**8)}".reverse
        end

        def set_user
          self.user = cart.user
        end
    end
  end
end

