Rails.application.routes.draw do
  
  get 'rooms/show'
  get 'messages/index', as: 'messages'
  post 'send_email', to: "email_notifications#send_email"

  devise_for :users, controllers: {
    omniauth_callbacks: 'devise_lib/omniauth_callbacks'
  }
  
  devise_scope :user do
    post 'omniauth_callbacks/facebook', to: "omniauth_callbacks#facebook_auth_by_token"
    post 'omniauth_callbacks/instagram', to: "devise_lib/omniauth_callbacks#instagram_auth_by_token"
  end

  
  root to: "home#index"

  get 'nearby_users', to: "users#nearby_users"
  get 'nearby_guests', to: "users#nearby_guests"
  
  resources :users
  resources :categories do
    resources :images
  end

  resources :messages, only: [:index] do
    member do
      post 'actions', to: 'actions#index'
    end
  end

  scope module: 'stripe_lib' do
    resources :charges
  end

  mount ActionCable.server => "/cable"
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
