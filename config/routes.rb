Rails.application.routes.draw do
  root to: 'posts#posts'
  get 'posts', to: 'posts#posts'
  get 'new', to: 'posts#new'
 
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  resources :posts, only: [:create, :destroy, :show]
end