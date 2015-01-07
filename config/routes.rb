Rails.application.routes.draw do

  get '/' => 'view#index'
  get '/boards' => 'view#boards'
  get '/board/:id' => 'view#board'

  namespace :api do
    post 'user/login' => 'user#login'
    post 'user/logout' => 'user#logout'
    post 'user/register' => 'user#register'
    post 'user/pinboard' => 'user#pin_board'
    post 'user/unpinboard' => 'user#unpin_board'
    get 'user/find/:name' => 'user#find'
    get 'user/current_user' => 'user#current'
    post 'user/:id/save' => 'user#save'

    resources :boards
    get 'boards/:id/flows' => 'boards#flows'
    post 'boards/:id/flows/add' => 'boards#add_flow'
    post 'boards/:id/flows/:fid/task/add' => 'boards#add_task'
    post 'baords/:id/users/delete/:uid' => 'boards#delete_user'
    post 'boards/:id/updatetaskorder' => 'boards#update_task_order'
    post 'boards/:id/users/add/:name' => 'boards#add_user'
    post 'boards/:id/task/move' => 'boards#task_move'

    post 'boards/:id/stash' => 'boards#stash'

    post 'flows/updateorder' => 'boards#update_flow_order'

    post 'update' => 'boards#update'

    get 'task/:id' => 'boards#get_task'
  end


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
