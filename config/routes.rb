Refinery::Core::Engine.routes.draw do

  # Frontend routes
  scope module: :carts do
    resource :cart do
      resources :line_items, :only => [:update, :destroy]
      resources :addresses
      get :shipping
      #get :payment#, constraints: { protocol: Rails.env.test?? 'http://' : 'https://' }
    end
    resources :orders, :except => [ :edit, :update, :destroy, :new ]#, constraints: { protocol: Rails.env.test?? 'http://' : 'https://' }
    match '/cart/payment', :to => 'orders#new'
      
  end

  # Admin routes
  namespace :carts, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :carts, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
