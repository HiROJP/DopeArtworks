Rails.application.routes.draw do
  root to: 'posts#posts'

  get 'signup', to: 'users#new'
  get 'posts', to: 'posts#posts'
  resources :users, only: [:index, :show, :new, :create]
end