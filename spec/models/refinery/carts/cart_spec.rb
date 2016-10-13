require 'spec_helper'

module Refinery
  module Carts
    describe Cart do
      describe "validations" do
        subject do
          FactoryGirl.create(:cart,
          :discount_code => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:discount_code) { should == "Refinery CMS" }
      end
    end
  end
end
