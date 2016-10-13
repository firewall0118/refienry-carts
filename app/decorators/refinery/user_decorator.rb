Refinery::User.class_eval do
  
  #has_many :carts, class_name: Refinery::Carts::Cart, foreign_key: :user_id
  #does the engine take care of this?
end
