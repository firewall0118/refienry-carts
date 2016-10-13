module Refinery
  module Carts
    module CartsHelper

      def cart_row(cart, format, text)
        content_tag :tr do
          content_tag(:th, text.capitalize, colspan: format ? 5 : 4, style: 'text-align: right') +
          content_tag(:td, number_to_currency(cart.send(text)), align: 'right')
        end.html_safe
      end

      def filtered_credit_card
        card = @cart.get_credit_card
        card[0..11] = '*'*12 unless card.blank?
        card  
      end
      
      def update_address_form(text, address, attr)
        form_for address, url: refinery.cart_address_path(address) do |f|
          f.hidden_field(attr, value: true) +
          hidden_field_tag(:payment, value: attr == :billing) +
          f.submit(text, class: 'btn btn-xs btn-primary', style: 'margin: 1px;')
        end
      end
    end
  end
end
