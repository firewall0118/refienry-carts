# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Carts" do
    describe "Admin" do
      describe "carts" do
        refinery_login_with :refinery_user

        describe "carts list" do
          before do
            FactoryGirl.create(:cart, :discount_code => "UniqueTitleOne")
            FactoryGirl.create(:cart, :discount_code => "UniqueTitleTwo")
            Refinery::Carts::Cart.any_instance.stub(user: Refinery::User.first)
          end

          it "shows two items" do
            visit refinery.carts_admin_carts_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            Refinery::Carts::Cart.any_instance.stub(user: Refinery::User.first)
            visit refinery.carts_admin_carts_path

            click_link "Add New Cart"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Discount Code", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Carts::Cart.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Discount Code can't be blank")
              Refinery::Carts::Cart.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:cart, :discount_code => "UniqueTitle") }

            it "should fail" do
              visit refinery.carts_admin_carts_path

              click_link "Add New Cart"

              fill_in "Discount Code", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Carts::Cart.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:cart, :discount_code => "A discount_code") }

          it "should succeed" do
            Refinery::Carts::Cart.any_instance.stub(user: Refinery::User.first)
            visit refinery.carts_admin_carts_path

            within ".actions" do
              click_link "Edit this cart"
            end

            fill_in "Discount Code", :with => "A different discount_code"
            click_button "Save"

            page.should have_content("'A different discount_code' was successfully updated.")
            page.should have_no_content("A discount_code")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:cart, :discount_code => "UniqueTitleOne") }

          it "should succeed" do
            Refinery::Carts::Cart.any_instance.stub(user: Refinery::User.first)
            visit refinery.carts_admin_carts_path

            click_link "Remove this cart forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Carts::Cart.count.should == 0
          end
        end

      end
    end
  end
end
