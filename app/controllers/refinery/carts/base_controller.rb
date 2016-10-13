module Refinery
  module Carts
    class BaseController < ::ApplicationController

      before_filter :find_cart
      helper_method :continue_shopping_path

      protected

      def continue_shopping_path
        '/'
      end
    
      def unauthenticated_redirect_path
        '/'
      end

      def verify_authenticated
        unless current_refinery_user
          respond_to do |format|
            format.html { redirect_to unauthenticated_redirect_path }
            format.js   { render js: "window.location.href = '#{unauthenticated_redirect_path}'" }
          end
        end
      end

    end
  end
end
