
FactoryGirl.define do
  factory :cart, :class => Refinery::Carts::Cart do
    sequence(:discount_code) { |n| "refinery#{n}" }
  end
end

