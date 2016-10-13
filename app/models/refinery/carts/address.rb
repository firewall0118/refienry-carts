class Refinery::Carts::Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :line_item
  attr_accessible :line_1, :line_2, :city, :state, :zip, :country, :billing, :default
  validates :line_1, :city, :zip, presence: true
  before_save :ensure_only_one_default, :ensure_only_one_billing
  before_save :ensure_still_one_billing, :ensure_still_one_default
  before_create :ensure_first_default_and_billing
  after_destroy :ensure_still_default_and_billing

  private

    def users_other_address
      user.addresses.where(addresses_table[:id].not_in [id]).first
    end

    def ensure_only_one_default # oooh clever
      if default && default_changed? 
        user.addresses.where(default: true).each {|addr| addr.update_column :default, false }
      end
    end

    def ensure_only_one_billing
      if user_id && billing && billing_changed? 
        user.addresses.where(billing: true).each {|addr| addr.update_column :billing, false }
      end
    end

    def ensure_first_default_and_billing
      if user.addresses.count == 0
        self.billing = true
        self.default = true
      end
      true
    end

    def ensure_still_default_and_billing
      if billing
        users_other_address.try :update_column, :billing, true
      end
      if default
        users_other_address.try :update_column, :default, true
      end
    end

    def ensure_still_one_billing
      if user_id && billing_changed? && billing_was
        users_other_address.try :update_column, :billing, true
      end
      true
    end

    def ensure_still_one_default
      if user_id && default_changed? && default_was
        users_other_address.try :update_column, :default, true
      end
      true
    end

    def addresses_table
      Arel::Table.new(:refinery_carts_addresses)
    end
end
