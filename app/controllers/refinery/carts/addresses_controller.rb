module Refinery
  module Carts
    class AddressesController < BaseController
      before_filter :verify_authenticated, only: [ :destroy ]
      before_filter :find_address, only: [ :destroy, :update, :edit ]
      
      def new
        @address = Address.new
      end
      
      def create
        @address = current_refinery_user.addresses.build params[:address]
        if @address.save
          flash.notice = "Address created."
          if params[:payment].to_i > 0
            redirect_to refinery.cart_payment_path
          else
            redirect_to refinery.shipping_cart_path
          end
        else
          render :new
        end
      end
      
      def destroy
        if @address
          @address.destroy
          flash.notice = "Address deleted."
          redirect_to refinery.shipping_cart_path
        else
          redirect_to '/' # trying to delete an address that is not theirs
        end
      end
      
      def edit

      end

      def update
        @address.update_attributes params[:address]
        redirect_to params[:payment].present?? refinery.cart_payment_path : refinery.shipping_cart_path
      end

      private

        def find_address
          @address = current_refinery_user.addresses.find params[:id]
        end
    end
  end
end
