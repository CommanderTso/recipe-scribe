Rails.application.routes.draw do
  root 'recipes#index'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  post '/add' => 'grocery_list#add'
  post '/remove' => 'grocery_list#add'

  resources :recipes
end
