Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]

  resources :tweets do
    member do
      get "like", to: "tweets#like"
      get "unlike", to: "tweets#unlike"
    end
    resources :comments

  end

  get 'home',to: 'users#home'

  root 'users#home'


end
