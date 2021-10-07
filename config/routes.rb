Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  get 'books/search' => 'books#search'
  get 'books/count/search' => 'books#count_search'
  resources :books, only: [:index, :create, :show, :edit, :destroy, :update, :destroy] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :index] do
    member do
      get :follows, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end
  resources :searches, only: [:index] 
  get 'searches/search'
  # post 'searches/search'
  resources :notifications, only: :index
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]
  resources :groups do
    resource :group_users, only: [:create, :destroy]
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end
  resources :tags do 
  end
  # post 'books/tags/search', to: 'books#search'
end