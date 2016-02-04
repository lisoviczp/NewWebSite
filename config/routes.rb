Rails.application.routes.draw do


  # root to: 'home#index'
  root to: 'posts#index'

  resources :posts

  devise_for :users
  # get 'home/index'

  # get 'about' => 'about#index'
  # get 'songs/show'
  # get 'songs/current'
  get 'about' => 'home#about'
  get 'music' => 'posts#music'

  get 'test' => 'posts#test'



  # get 'posts/approve' => 'pictures#approve'
  # get 'posts/last_approve' => 'pictures#get_last_approve', as: 'get_last_approve'


  # post 'posts/approveThePic/:id' => 'posts#approveThePost', as: 'approve_the_post_post'
  # get 'posts/approveThePic/:id' => 'posts#approveThePost', as: 'approve_the_post_get'

  # get 'posts/approve/:id' => 'posts#approve', as: 'post_approve'


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
