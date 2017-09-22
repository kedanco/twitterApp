Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users

  resources :tweets do
    member do
      get "like", to: "tweets#upvote"
      get "dislike", to: "tweets#downvote"
    end
    resources :comments

  end

  get 'home',to: 'users#home'

  root 'users#index'


end
