SPC2::Application.routes.draw do
  
  #  get "oauths/oauth"
  #  get "oauths/callback"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"


  resources :users, :only => [:new, :create, :edit, :update, :show, :contact] do
    collection do
      get "logged_in"
      get "update_phone"
    end
    member do
      get "inbox"
    end
  end
  resources :sessions, :only => [:new, :create, :destroy] do
    collection do
      get "temp_redirect"
      get 'facebook_login'
      get 'facebook_callback'
    end
  end
  resources :rides, :only => [:index, :new, :create, :edit, :update] do
    collection do
      get "search"
      get "searchclone"
      post "post_one"
      post "posted"
      get "create_ride"
      get "post_one" => "rides#posted_one"
      post "post_two"
      get "update_post_two"
      get "update_post_three"
      put "posted" => "rides#updated"
      put "updated"
    end
    member do
      get "clone"
    end
    resources :ride_participants, :only => [:new, :create, :update] do
      collection do
        get "create_participant"
      end
      member do

        get "contact"
        post "create_message"
        get "cancel"
        get "accept"
        get "deny"
      end
    end
    resource :message, :only => [:new, :create, :show]
  end
  resource :dashboard, :only => [:show]
  resource :feedback, :only => [:new, :create, :show]
  resources :footers do
    collection do
      get "terms"
      get "how_it_works"
      get "about"
    end
  end

  root :to => "rides#search"

  match "oauth/callback" => "oauths#callback"
  match "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end




  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  #   match ':controller(/:action(/:id))(.:format)'
end
