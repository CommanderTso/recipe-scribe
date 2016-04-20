Rails.application.routes.draw do
  root 'recipes#index'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  resources :recipes, only: [:index, :show, :new, :create]
end
