Rails.application.routes.draw do
  root 'recipes#index'

  resources :recipes, only: [:index, :new, :create]
end
