module Refinery
  module Carts
    class OrdersController < BaseController
      helper CartsHelper
      #force_ssl only: :create if Rails.env.production?

      def index# not :post order. this is a :get index of previous orders.
        @orders = current_refinery_user.orders.order('created_at DESC')
      end
      
      def new
        @order = Refinery::Carts::Order.new
        @address = current_refinery_user.billing_address
        redirect_to refinery.new_cart_address_url(payment: 1) unless @address
      end
      
      def create
        if capture_credit_card
          find_cart
          @order = @cart.create_order(params[:order].merge(address_id: current_refinery_user.billing_address.id))

          session[:cart_id] = current_refinery_user.carts.create.id
          redirect_to refinery.order_url(@order), notice: "Your order has been placed. Confirmation number: #{@order.confirmation_number}"
        else
          @order = Refinery::Carts::Order.new
          @address = current_refinery_user.billing_address
          @addresses = current_refinery_user.addresses 
          render :new
        end
      end

      def show
        @order = Refinery::Carts::Order.where(confirmation_number: params[:id]).first
      end
      private

        def capture_credit_card
          true #overwrite
        end

    end
  end
end
