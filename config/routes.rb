Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "gostations#index"
  
  resources :users, only: [:show]
   
  resources :gostations, only:[:index]

  resources :challenges, only:[:create]


  resources :trip_gostations, only:[:show] do 
    member do 
      post :check
    end
  end 
  

  resources :trips, only:[:index, :show] 

  namespace :admin do
    root "gostations#index"
    resources :gostations
    resources :trips
  end


end
