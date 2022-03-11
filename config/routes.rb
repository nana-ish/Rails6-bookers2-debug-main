Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "homes#top"
  get "home/about"=>"homes#about"
  resources :books
  resources :users
  get "search" => "searches#search"

  resources :books do
   resource :favorites, only: [:create, :destroy]                 #favoriteは番号いらない
   resources :book_comments,only: [:create,:destroy]
  end

  resources :users do
    resource :relationships,only:[:create,:destroy]
      get :followeds,on: :member
      get :followers,on: :member
  end

  resources :rooms, only: [:show, :create]
  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats,only: [:create]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end