module Refinery
  module Carts
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Carts

      engine_name :refinery_carts

      initializer "register refinerycms_carts plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "carts"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.carts_admin_carts_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/carts/cart',
            :title => 'discount_code'
          }
          
        end
      end

      initializer "refinerycms_carts.find_cart" do
        ActiveSupport.on_load(:action_controller) do
          include Carts::CartFinderHelper
        end
      end

      config.to_prepare do
        ::Refinery::User.class_eval do
          has_many  :addresses, class_name: ::Refinery::Carts::Address, dependent: :destroy
          has_one   :billing_address, class_name: ::Refinery::Carts::Address,
                                      conditions: { billing: true } 
          has_one   :default_shipping_address, class_name: ::Refinery::Carts::Address,
                                             conditions: { default: true } # address can be billing & shipping
          [ :line_1, :line_2, :city, :state, :zip, :country ].each do |address_component|
            delegate address_component, to: :billing_address, prefix: true
            delegate address_component, to: :default_shipping_address, prefix: true
          end
          has_many :carts, class_name: ::Refinery::Carts::Cart, dependent: :destroy
          has_many :orders, class_name: ::Refinery::Carts::Order, dependent: :destroy
          accepts_nested_attributes_for :billing_address, reject_if: :blank_except_country?
          accepts_nested_attributes_for :default_shipping_address, reject_if: :all_blank
          accepts_nested_attributes_for :addresses, reject_if: :all_blank

          private

            def blank_except_country?(attr_hash)
              attr_hash.all?{|k, v| v.blank? || k == 'country'}
            end
        end  
      end 

    end
  end
end
