# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :refinery_carts_address, :class => 'Refinery::Carts::Address' do
    line_1 "MyString"
    line_1 "MyString"
    city "MyString"
    state "MyString"
    zip 1
    user nil
    line_item nil
  end
end
