Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users

<<<<<<< HEAD
  resources :tweets do
    resources :comments 
  end

  get 'home',to: 'users#home'

  root 'users#index'

=======
  resources :tweets
  
  get 'home',to: 'users#home'

  root 'users#show'
  
>>>>>>> fcdcc9000a873a916d0f0c52c310e1103c0036c8
end
