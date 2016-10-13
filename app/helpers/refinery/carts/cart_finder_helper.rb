module Refinery
  module Carts

    module CartFinderHelper
      def find_cart
        if session[:cart_id]
          if current_refinery_user
            @cart = current_refinery_user.carts.find_by_id(session[:cart_id])
          else
            @cart = Cart.where(id: session[:cart_id], user_id: nil).first
          end
        elsif current_refinery_user
          @cart = current_refinery_user.carts.where(paid: false).last
        end
        @cart ||= Cart.create(user: current_refinery_user)
        session[:cart_id] = @cart.id
      end
    end
  end
end
