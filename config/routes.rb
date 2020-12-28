Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users
  get 'add_friend' => 'users#add_friend', as: 'add_friend'
  get 'notifications' => 'users#notifications', as: 'notifications'
  resources :users, only: [:index, :show, :notifications]

  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
