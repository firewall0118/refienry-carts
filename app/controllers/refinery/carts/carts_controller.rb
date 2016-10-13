module Refinery
  module Carts
    class CartsController < BaseController
      before_filter :set_addresses, only: [ :shipping, :payment ]
      before_filter :redirect_if_paid, except: [ :update ]
      #force_ssl only: :payment if Rails.env.production?
      
      def show
        
      end
      
      def update
        if @cart.update_attributes params[:cart]
          respond_to do |format|
            url = refinery.send "#{pages[:next]}_url", pages[:protocol]
            format.html { redirect_to url }
            format.js { render :update }
          end
        else
          flash.alert "There was an error saving the cart."
          render pages[:current]
        end
      end
      
      def shipping
        # load all the addresses for the user, and create one default address based on their home address
      end

      def express
        # use default shipping address for each line item and default credit card
        # TODO
        render :confirmation
      end
      
      private

      def pages
        case params[:commit]
        when /Apply/
          flash.notice = "Your discount code has been applied." 
          { next: 'cart' }
        when /Continue/
          { current: :shipping, next: 'cart_payment', protocol: protocol }
        when /Ship All/
          { next: 'shipping_cart' }
        else
          { next: 'cart' }
        end
      end
                  
      def redirect_if_paid
        redirect_to refinery.order_url(@cart.order) if @cart.paid
      end

      def set_addresses
        @addresses = current_refinery_user.addresses 
      end

      def protocol
        Rails.env.test?? {} : { protocol: 'https' }
      end
    end
  end
end
