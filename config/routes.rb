Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users
  root to: "homes#top"
  get "home/about"=>"homes#about"
  resources :books
  resources :users

  resources :books do
   resources :favorites, only: [:create, :destroy]
   resources :book_comments,only: [:create,:destroy]
  end

  resources :users do
    resource :relationships,only:[:create,:destroy]
      get :followeds,on: :member
      get :followers,on: :member
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end