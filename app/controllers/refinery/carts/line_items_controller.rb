module Refinery
  module Carts
    class LineItemsController < BaseController
      before_filter :find_line_item

      def update
        @line_item.update_attributes(params[:line_item])
        respond_to do |format|
          format.html { redirect_to refinery.cart_path }
          format.js   
        end
      end

      def destroy
        @line_item.delete
        respond_to do |format|
          format.html { redirect_to refinery.cart_path }
          format.js   { render javascript: 1 }
        end
      end
      
      private

        def find_line_item
          @line_item = LineItem.find params[:id]
        end

    end
  end
end
