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

end
