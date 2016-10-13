module Refinery
  module Carts
    module Admin
      class CartsController < ::Refinery::AdminController

        crudify :'refinery/carts/cart',
                :title_attribute => 'id',
                :xhr_paging => true,
                :order => 'updated_at desc'

      end
    end
  end
end
