# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :line_item, :class => 'Refinery::Carts::LineItem' do
    cart nil
    product_id "MyString"
    qty 1
    unit_price "9.99"
    virtual ""
    address nil
  end
end
